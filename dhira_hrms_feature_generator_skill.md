# Skill: Feature Developer — Dhira HRMS

> Invoke this skill whenever you are asked to **create a new feature** or **update an existing feature** in the Dhira HRMS project.  
> Work through every section in order. Never skip a section.

---

## 0 · Before Writing a Single Line

1. Read `README.md` for the current architecture overview.
2. Read `lib/core/di/dependency_injection.dart` to understand what is already registered.
3. Read `lib/core/theme/app_colors.dart` and `lib/core/theme/app_text_style.dart` — these are the **only** sources of colors and typography.
4. Read `lib/l10n/app_localizations.dart` — every user-visible string must come from here.
5. Read `lib/core/constants/storage_constants.dart` — every SharedPreferences key must be a constant defined there.
6. Scan the most similar existing feature (e.g. `leave`, `attendance`) to infer the naming and file layout convention.
7. If the project has a `graphify-out/` folder, run `graphify query "<feature name>"` first to understand existing edges before creating new files.

---

## 1 · Folder & File Layout

Every feature lives at `lib/features/<snake_case_name>/` and follows this exact structure:

```
lib/features/<feature>/
├── data/
│   ├── constants/          <feature>_api_constants.dart         — API endpoint strings only
│   ├── datasources/        <feature>_remote_datasource.dart     — interface + implementation
│   ├── models/             <feature>_model.dart                 — @freezed + @JsonSerializable
│   └── repositories/       <feature>_repository_impl.dart       — implements domain interface
├── domain/
│   ├── entities/           <feature>_entity.dart                — plain Dart / @freezed
│   ├── repositories/       i_<feature>_repository.dart          — abstract interface
│   └── usecases/           get_<action>_usecase.dart            — one file per use-case
└── presentation/
    ├── bloc/
    │   ├── <feature>_bloc.dart
    │   ├── <feature>_event.dart
    │   └── <feature>_state.dart
    ├── screens/            <feature>_screen.dart
    └── widgets/            <feature>_<component>_widget.dart
```

**Rules**:
- No file may import across feature boundaries except through the domain layer.
- `presentation/` may NOT import `data/` directly.
- `domain/` must import nothing from `data/` or `presentation/`.

---

## 2 · Layer-by-Layer Rules

### 2.1 Data Layer

#### Models (`data/models/`)
- Always use `@freezed` + `@JsonSerializable`.
- Always use `@JsonKey(name: 'snake_case_key')` when the API key differs from the Dart field name.
- Provide a `toEntity()` method that returns the domain entity.
- Never expose the model outside the data layer — convert to entity at the repository boundary.

```dart
// ✅ Correct pattern
@freezed
abstract class LeaveModel with _$LeaveModel {
  const factory LeaveModel({
    @JsonKey(name: 'leave_type') required String leaveType,
    @JsonKey(name: 'from_date')  required String fromDate,
    @Default(0) int status,
  }) = _LeaveModel;

  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);
}

extension LeaveModelMapper on LeaveModel {
  LeaveEntity toEntity() => LeaveEntity(
        leaveType: leaveType,
        fromDate: fromDate,
        status: LeaveStatus.fromCode(status),   // ← use a constant/enum, not raw int
      );
}
```

#### Remote Data Source (`data/datasources/`)
- Define an **abstract interface** and a **concrete implementation** in the same file.
- Use injected `DioClient` — never instantiate `Dio` directly.
- **Do NOT** set `Content-Type: application/json` — `DioClient` does this globally.
- **Do NOT** check `response.statusCode` manually — `DioClient` throws `ServerException` on non-2xx.
- **Do NOT** use `debugPrint` — use the injected `Logger`.
- **Do NOT** catch exceptions here — let them propagate to the repository.

```dart
// ✅ Correct datasource implementation
class LeaveRemoteDataSourceImpl implements ILeaveRemoteDataSource {
  LeaveRemoteDataSourceImpl({required this.dioClient, required this.logger});

  final DioClient dioClient;
  final Logger logger;

  @override
  Future<List<LeaveModel>> fetchLeaves(String empId) async {
    final response = await dioClient.get(LeaveApiConstants.list, queryParameters: {'employee': empId});
    final data = response.data as List<dynamic>;
    return data.map((e) => LeaveModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
```

#### Repository Implementation (`data/repositories/`)
- Implements the domain interface.
- **Always** wrap every call in `networkInfo.connectedAndRun(...)`.
- **Always** return `Either<Failure, T>`.
- Catch `ServerException` → `ServerFailure`, `NetworkException` → `NetworkFailure`, `UnauthorizedException` → `UnauthorizedFailure`. No other exception types should be caught silently.
- On error, `emit` the previous state (rollback) before returning a failure — see BLoC section.

```dart
// ✅ Correct repository implementation
@override
Future<Either<Failure, List<LeaveEntity>>> getLeaves(String empId) =>
    networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.fetchLeaves(empId);
        return Right(models.map((m) => m.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    });
```

---

### 2.2 Domain Layer

#### Entities (`domain/entities/`)
- Use `@freezed` OR `Equatable` (match the convention already used in the feature's sibling entities).
- No JSON serialization — entities are pure Dart.
- No methods that touch `DioClient`, `SharedPreferences`, or any Flutter framework class.

#### Repository Interface (`domain/repositories/`)
- Prefix with `I` (e.g., `ILeaveRepository`).
- All methods return `Future<Either<Failure, T>>`.

#### Use Cases (`domain/usecases/`)
- One class, one public method `call(Params)`.
- Returns `Either<Failure, T>` by delegating to the repository.
- Contains business logic that does NOT belong in the BLoC (e.g. eligibility rules, gender-based filtering).

```dart
class GetLeavesUseCase {
  GetLeavesUseCase(this.repository);
  final ILeaveRepository repository;

  Future<Either<Failure, List<LeaveEntity>>> call(String empId) =>
      repository.getLeaves(empId);
}
```

---

### 2.3 Presentation Layer

#### Events (`bloc/<feature>_event.dart`)
- Use `@freezed`.
- **Generated concrete class names must be PUBLIC (no `_` prefix)** so they can be used as type arguments in `on<ConcreteEventType>()` across files.

```dart
// ✅ Correct — public generated names
@freezed
abstract class LeaveEvent with _$LeaveEvent {
  const factory LeaveEvent.started()                          = LeaveStarted;
  const factory LeaveEvent.fetchRequested(String empId)       = LeaveFetchRequested;
  const factory LeaveEvent.submitRequested(LeaveEntity leave) = LeaveSubmitRequested;
}

// ❌ Wrong — private names break on<> registration in bloc file
const factory LeaveEvent.started() = _Started;
```

#### States (`bloc/<feature>_state.dart`)
- Use `@freezed`.
- Avoid a "detail loaded" state that duplicates "loaded" — reuse `loaded` with optional fields.
- All shared getters on the abstract class must NOT carry `@override` (there is no supertype declaring them).
- Boolean loading flags (`isActionLoading`) belong on the base fields, not in a separate state variant.

```dart
@freezed
abstract class LeaveState with _$LeaveState {
  const factory LeaveState.initial({
    @Default([]) List<LeaveEntity> leaves,
    @Default(false) bool isActionLoading,
    UserEntity? user,
  }) = LeaveInitial;

  const factory LeaveState.loading({
    @Default([]) List<LeaveEntity> leaves,
    @Default(false) bool isActionLoading,
    UserEntity? user,
  }) = LeaveLoading;

  const factory LeaveState.loaded({
    required List<LeaveEntity> leaves,
    @Default(false) bool isActionLoading,
    UserEntity? user,
  }) = LeaveLoaded;

  const factory LeaveState.success({
    required String message,
    required List<LeaveEntity> leaves,
    @Default(false) bool isActionLoading,
    UserEntity? user,
  }) = LeaveSuccess;

  const factory LeaveState.error({
    required String message,
    required List<LeaveEntity> leaves,
    @Default(false) bool isActionLoading,
    UserEntity? user,
  }) = LeaveError;
}

// Convenience getters on the abstract type — NO @override annotation
extension LeaveStateX on LeaveState {
  List<LeaveEntity> get leaves => maybeMap(
        loaded:  (s) => s.leaves,
        success: (s) => s.leaves,
        error:   (s) => s.leaves,
        orElse:  () => [],
      );

  bool get isActionLoading => maybeMap(
        orElse: () => false,
        loaded:  (s) => s.isActionLoading,
        success: (s) => s.isActionLoading,
        error:   (s) => s.isActionLoading,
      );
}
```

#### BLoC (`bloc/<feature>_bloc.dart`)
- **Individual `on<ConcreteEventType>()` handler per event** — never a single mega `on<FeatureEvent>` with a switch/map inside.
- Constructor injects use cases + `LocalStorageService` — **never** `SharedPreferences` or `IAuthRepository` directly.
- Read user identity from `LocalStorageService` (e.g. `localStorageService.getEmpId()`).
- On action failure: emit `previousState.copyWith(isActionLoading: false)` before the failure return (rollback).
- Use `dart:developer`'s `log()` for debug output — **never** `debugPrint`.

```dart
class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc({
    required this.getLeavesUseCase,
    required this.localStorageService,
  }) : super(const LeaveState.initial()) {
    on<LeaveStarted>(_onStarted);
    on<LeaveFetchRequested>(_onFetchRequested);
    on<LeaveSubmitRequested>(_onSubmitRequested);
  }

  final GetLeavesUseCase getLeavesUseCase;
  final LocalStorageService localStorageService;

  Future<void> _onStarted(LeaveStarted event, Emitter<LeaveState> emit) async {
    emit(const LeaveState.loading());
    final empId = localStorageService.getEmpId() ?? '';
    add(LeaveFetchRequested(empId));
  }

  Future<void> _onFetchRequested(LeaveFetchRequested event, Emitter<LeaveState> emit) async {
    final result = await getLeavesUseCase(event.empId);
    result.fold(
      (failure) => emit(LeaveState.error(message: failure.message, leaves: state.leaves)),
      (leaves)  => emit(LeaveState.loaded(leaves: leaves)),
    );
  }

  Future<void> _onSubmitRequested(LeaveSubmitRequested event, Emitter<LeaveState> emit) async {
    final previous = state;
    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    ));
    // ... call use case
    result.fold(
      (failure) {
        emit(previous.copyWith(isActionLoading: false)); // rollback
        emit(LeaveState.error(message: failure.message, leaves: state.leaves));
      },
      (_) => emit(LeaveState.success(message: 'Submitted', leaves: state.leaves)),
    );
  }
}
```

---

### 2.4 Presentation — UI

#### Screens (`presentation/screens/`)
- Screens are **coordinators**, not builders. They:
  - Provide the BLoC via `BlocProvider` (NOT `BlocProvider.value` unless navigating with an existing bloc).
  - Listen for navigation side-effects via `BlocListener`.
  - Pass data to widgets via constructor params derived from `BlocBuilder` state.
- Screens must **not** contain `Column`, `ListView`, decoration logic, or business conditions. Extract those into named widget files.
- Cache computed values in `initState` or `State` fields — never recompute in `build`.
- Never call `setState` from inside `build()`.
- Use `WidgetsBinding.instance.addPostFrameCallback` for side-effects after first frame (e.g. initial BLoC event dispatch).

```dart
// ✅ Correct screen shell
class LeaveScreen extends StatefulWidget { ... }

class _LeaveScreenState extends State<LeaveScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeaveBloc>().add(const LeaveEvent.started());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaveBloc, LeaveState>(
      listenWhen: (_, curr) => curr.maybeMap(success: (_) => true, error: (_) => true, orElse: () => false),
      listener: (context, state) {
        state.maybeWhen(
          success: (msg, ...) => ToastUtils.showSuccess(msg),
          error:   (msg, ...) => ToastUtils.showError(msg),
          orElse:  () {},
        );
      },
      child: BlocBuilder<LeaveBloc, LeaveState>(
        builder: (context, state) => LeaveBody(leaves: state.leaves, isLoading: state.isActionLoading),
      ),
    );
  }
}
```

#### Widgets (`presentation/widgets/`)
- Widgets are **dumb** — they receive data and callbacks, they don't read the BLoC themselves (unless they are a self-contained leaf that genuinely owns a sub-state).
- Widgets must NOT import `shared_preferences`, `DioClient`, `IRepository`, or any data-layer class.
- Widgets must NOT call `Get.find<>()` except for base-URL resolution via `AppConstants`.
- Use `const` constructors wherever possible.
- Use `RepaintBoundary` on widgets that animate independently.

---

## 3 · Core Classes — What to Use and Where

| Need | Class / Location | Notes |
|------|-----------------|-------|
| Colors | `AppColors` — `lib/core/theme/app_colors.dart` | No hex literals in widget files |
| Text styles | `AppTextStyle` — `lib/core/theme/app_text_style.dart` | `.copyWith()` to adjust only specific properties |
| User-visible strings | `AppLocalizations.of(context)!.<key>` | Add new keys to **both** `app_en.arb` and `app_hi.arb` AND both `app_localizations_en.dart` / `app_localizations_hi.dart` and the abstract `app_localizations.dart` |
| Storage keys | `StorageConstants` — `lib/core/constants/storage_constants.dart` | Never write raw string keys in code |
| Status/doc codes | Add to `lib/core/constants/app_constants.dart` or a feature-specific `constants/` file | e.g. `static const int docStatusDraft = 0` |
| Toast messages | `ToastUtils.showSuccess/showError/showInfo` — `lib/core/utils/toast_utils.dart` | |
| Date formatting | `DateTimeUtils` — `lib/core/utils/date_time_utils.dart` | |
| Logging | `dart:developer` `log(...)` | Never `debugPrint` in production code |

---

## 4 · Status Codes & Magic Numbers — Zero Tolerance Policy

Every integer or string status code that maps to a business concept must be a named constant.

```dart
// ❌ Wrong
if (ts.docStatus == 0) { ... }
if (leave.status == 'Open') { ... }

// ✅ Correct — in app_constants.dart or feature constants file
static const int docStatusDraft    = 0;
static const int docStatusSubmitted = 1;
static const String leaveStatusOpen = 'Open';

// Then in code:
if (ts.docStatus == AppConstants.docStatusDraft) { ... }
```

---

## 5 · Localization — Adding New Strings

Every time you write a user-facing string literal, stop and follow these 4 steps instead:

1. Add the key + English value to `lib/l10n/app_en.arb`.
2. Add the key + Hindi value to `lib/l10n/app_hi.arb`.
3. Add the abstract getter to `lib/l10n/app_localizations.dart`.
4. Add the `@override` implementation to both `app_localizations_en.dart` and `app_localizations_hi.dart`.

```dart
// In widget:
Text(AppLocalizations.of(context)!.leaveSubmitSuccess)

// ❌ Never:
Text('Leave submitted successfully')
```

---

## 6 · Dependency Injection — Registration Checklist

After creating a new feature, add to `dependency_injection.dart` in this order:

```dart
// 1. Data Source
Get.lazyPut<ILeaveRemoteDataSource>(
  () => LeaveRemoteDataSourceImpl(
    dioClient: Get.find<DioClient>(),
    logger: Get.find<Logger>(),
  ),
  fenix: true,
);

// 2. Repository
Get.lazyPut<ILeaveRepository>(
  () => LeaveRepositoryImpl(
    remoteDataSource: Get.find<ILeaveRemoteDataSource>(),
    networkInfo: Get.find<NetworkInfo>(),
  ),
  fenix: true,
);

// 3. Use Cases (one entry per use case)
Get.lazyPut(() => GetLeavesUseCase(Get.find<ILeaveRepository>()), fenix: true);

// 4. BLoC
Get.lazyPut(
  () => LeaveBloc(
    getLeavesUseCase: Get.find<GetLeavesUseCase>(),
    localStorageService: Get.find<LocalStorageService>(),
  ),
  fenix: true,
);
```

---

## 7 · Routing

Add routes to `lib/core/routing/app_router.dart`:

```dart
GoRoute(
  path: AppRouter.leavePath,           // define path constant in AppRouter
  name: AppRouter.leaveName,           // define name constant in AppRouter
  builder: (context, state) => BlocProvider(
    create: (_) => Get.find<LeaveBloc>(),
    child: const LeaveScreen(),
  ),
),
```

---

## 8 · Code Generation

Always run after modifying any `@freezed` or `@JsonSerializable` file:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Then verify with:

```bash
flutter analyze
```

Zero new errors or warnings are required before the implementation is considered complete.

---

## 9 · Anti-Pattern Reference — Things That Are Always Wrong

| Anti-pattern | Why it's wrong | Fix |
|---|---|---|
| `SharedPreferences.getInstance()` inside a BLoC | BLoC is presentation layer; storage is data layer | Use injected `LocalStorageService` |
| `debugPrint(...)` in any non-test file | Leaks data in production builds | Use `dart:developer` `log(...)` |
| `Options(headers: {"Content-Type": "application/json"})` in datasource | `DioClient` sets it globally | Remove the Options |
| `if (response.statusCode == 200)` in datasource | `DioClient` throws on non-2xx | Remove the check; catch exceptions in repo |
| Hardcoded color `Color(0xFF...)` in a widget | Breaks theming | Use `AppColors.*` |
| Hardcoded `TextStyle(...)` in a widget | Breaks typography system | Use `AppTextStyle.*` |
| `Text('Some label')` in a widget | Not translatable | Use `AppLocalizations.of(context)!.someLabel` |
| Raw `'pref_key'` string in storage read/write | Typo-prone, not refactor-safe | Use `StorageConstants.someKey` |
| `if (status == 0)` or `if (docStatus == 1)` | Magic numbers | Use named constants |
| Feature-local color/style class (e.g. `TimesheetColors`) | Duplicates theme system | Delete and use `AppColors`/`AppTextStyle` |
| `BlocProvider.value` for a fresh screen push | Bloc lifecycle is wrong | Use `BlocProvider(create: ...)` |
| `on<_PrivateEventType>()` across files | Private type not visible outside library | Use public generated names (no `_` prefix) |
| `@override` on getters in freezed abstract class with no supertype | Incorrect annotation, analyzer warning | Remove `@override` |
| Business logic (filtering, eligibility checks) inside BLoC handler | Untestable, violates SRP | Move to a dedicated UseCase |
| Importing `data/` layer directly from a widget | Breaks layer separation | Widget reads from BLoC state only |
| Multiple `setState` calls in a single handler | Triggers multiple rebuilds | Batch into one `setState` |
| `setState` from inside `build()` | Infinite rebuild loop | Move to gesture callbacks or `initState` |
| `addPostFrameCallback` called on every `build` | Fires on every rebuild | Call only once, in `initState` |

---

## 10 · Verification Checklist

Before marking any feature complete, confirm every item:

- [ ] `flutter analyze` reports zero new errors and zero new warnings
- [ ] `dart run build_runner build --delete-conflicting-outputs` completes without error
- [ ] No `debugPrint` in any non-test file (`grep -r "debugPrint" lib/`)
- [ ] No raw hex color literals in widget files (`grep -r "Color(0x" lib/features/`)
- [ ] No hardcoded `TextStyle(` in widget files (use `AppTextStyle`)
- [ ] No raw user-visible string literals in widget files (use `AppLocalizations`)
- [ ] No `SharedPreferences.getInstance()` outside `LocalStorageService`
- [ ] No `Content-Type` header set in datasource methods
- [ ] All new `@freezed` event types use public (non-`_`) generated names
- [ ] All new DI registrations use `fenix: true`
- [ ] All new routes added to `app_router.dart` with named constants
- [ ] All new string constants in `app_en.arb`, `app_hi.arb`, and both `app_localizations_*.dart` files
- [ ] All new storage keys added to `StorageConstants`
- [ ] All status code integers replaced with named constants
- [ ] Graphify updated: `graphify update .`

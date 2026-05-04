# Attendance Regularization — Code Review Report

**Project:** `dhira_hrms`
**Feature path:** `lib/features/attendance/`
**Flow under review:** `AttendanceRegularizationScreen` (and full Data → Domain → Presentation chain)
**Reviewed against:** `README.md` (Clean Architecture rules) + `dhira_hrms_feature_generator_skill.md`
**Date:** 2026-04-28
**Reviewer:** Static review (Claude Code), no runtime tests executed.

> Purpose: hand this report to an AI assistant to apply the fixes. Each finding lists the **file:line**, the **rule it violates**, the **why**, and the **suggested fix**. Findings are grouped by severity. Severity legend:
> - **B (Blocker)** — likely a runtime/UX bug or data-correctness issue.
> - **H (High)** — clear architecture / skill-rule violation that will cause future churn.
> - **M (Medium)** — code-quality / maintainability defect.
> - **L (Low)** — polish / nit.

---

## 0. Tooling note — Graphify

`CLAUDE.md` references a `graphify` CLI for knowledge-graph queries, but it is **not installed** on this machine and is **not available** on npm or PyPI (`npm view graphify-cli` → 404, `pip install graphify` → no matching distribution). No `graphify-out/` folder exists at the repo root. If `graphify` is an internal Anthropic / private tool, install it via the proper channel before running `graphify update .`. For this review I used direct file inspection instead.

**Action item for the user:** confirm where `graphify` ships from, then add an install step to `README.md`'s "Getting Started" section so the rule in `CLAUDE.md` is actionable.

---

## 1. Files in scope

### Data layer
- [attendance_api_constants.dart](lib/features/attendance/data/constants/attendance_api_constants.dart)
- [attendance_regularization_model.dart](lib/features/attendance/data/models/attendance_regularization_model.dart)
- [attendance_remote_datasource.dart](lib/features/attendance/data/datasources/attendance_remote_datasource.dart)
- [attendance_repository_impl.dart](lib/features/attendance/data/repositories/attendance_repository_impl.dart)

### Domain layer
- [attendance_regularization_entity.dart](lib/features/attendance/domain/entities/attendance_regularization_entity.dart)
- [attendance_repository.dart](lib/features/attendance/domain/repositories/attendance_repository.dart)
- [submit_regularization_use_case.dart](lib/features/attendance/domain/usecases/submit_regularization_use_case.dart)
- [upload_file_use_case.dart](lib/features/attendance/domain/usecases/upload_file_use_case.dart)

### Presentation layer
- [attendance_regularization_screen.dart](lib/features/attendance/presentation/screens/attendance_regularization_screen.dart)
- [attendance_regularization_bloc.dart](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart)
- [attendance_regularization_event.dart](lib/features/attendance/presentation/bloc/attendance_regularization_event.dart)
- [attendance_regularization_state.dart](lib/features/attendance/presentation/bloc/attendance_regularization_state.dart)
- [attendance_regularization_body.dart](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart)
- [regularization_date_picker.dart](lib/features/attendance/presentation/widgets/regularization_date_picker.dart)
- [regularization_guidelines.dart](lib/features/attendance/presentation/widgets/regularization_guidelines.dart)
- [regularization_system_record.dart](lib/features/attendance/presentation/widgets/regularization_system_record.dart)
- [regularization_request_type.dart](lib/features/attendance/presentation/widgets/regularization_request_type.dart)
- [regularization_details_section.dart](lib/features/attendance/presentation/widgets/regularization_details_section.dart)
- [regularization_documents_section.dart](lib/features/attendance/presentation/widgets/regularization_documents_section.dart)
- [regularization_action_buttons.dart](lib/features/attendance/presentation/widgets/regularization_action_buttons.dart)

### Wiring
- [dependency_injection.dart](lib/core/di/dependency_injection.dart) (lines 274-281, 454-460)
- [app_router.dart](lib/core/routing/app_router.dart) (lines 39-40, 138-143)

---

## 2. Findings

### 2.1 BLOCKERS (B)

#### B-1. Submit always saves as Draft, never Submitted
**Files:** [attendance_remote_datasource.dart:268-283](lib/features/attendance/data/datasources/attendance_remote_datasource.dart:268), [attendance_regularization_model.dart:11](lib/features/attendance/data/models/attendance_regularization_model.dart:11)
**Issue:** `docstatus` defaults to `AppConstants.docStatusDraft (0)` and the FormData `action` is hardcoded to `'Save'`. In Frappe, `Save` keeps the doc in Draft state — Submit requires `action: 'Submit'` (or `docstatus: 1`). The current "Submit Request" button therefore creates a draft that an approver will never see.
**Fix:**
1. Change default `docStatus` in the model factory to `AppConstants.docStatusSubmitted` (add this constant — currently only `docStatusDraft` exists, see [app_constants.dart:71](lib/core/constants/app_constants.dart:71)).
2. Change `'action': 'Save'` → `'action': 'Submit'` in the datasource FormData.
3. Or, cleaner: pass the action via a parameter so the same endpoint can be used for both save-as-draft and submit.

#### B-2. Deleting an uploaded file leaves stale `uploadedFileUrl` in state
**Files:** [attendance_regularization_body.dart:197-199](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:197), [attendance_regularization_bloc.dart](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart)
**Issue:** When the user taps the delete icon, only local `_selectedFileName` is cleared. `state.uploadedFileUrl` is **not** reset, so:
- The "✅ File Uploaded" branch of `RegularizationDocumentsSection` keeps rendering (it checks `uploadedFileUrl != null`, see [regularization_documents_section.dart:49](lib/features/attendance/presentation/widgets/regularization_documents_section.dart:49)).
- The next `Submit` will still attach the previously-uploaded URL via `_submit(context, state.uploadedFileUrl)` ([attendance_regularization_body.dart:208](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:208)).
**Fix:** Add a `FileRemoved` event to the bloc that emits `state.copyWith(uploadedFileUrl: null, isFileUploadSuccess: false, selectedFileName: null)`. Move `selectedFileName` into BLoC state so the body widget no longer holds it.

#### B-3. `uploadedFileUrl` and `isFileUploadSuccess` are not reset after a successful submission
**Files:** [attendance_regularization_bloc.dart:40-46](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart:40)
**Issue:** After `SubmitRequested` succeeds, only `isSubmitting` and `isSubmissionSuccess` are updated. The previous `uploadedFileUrl` lingers. Consequence: if the user starts a *second* regularization in the same session, the body widget calls `resetUI()` (local state) but the BLoC state still carries `uploadedFileUrl` from the prior submission. The Documents section will render "File Uploaded ✅" with the *old* URL, and a fresh submit will reattach the wrong file.
**Fix:** On submission success, emit a fully-reset state:
```dart
emit(const AttendanceRegularizationState(isSubmissionSuccess: true));
```
Or add an explicit `Reset` event called from `resetUI()`.

#### B-4. `successMessage` branch in screen listener is dead code
**File:** [attendance_regularization_screen.dart:24-28](lib/features/attendance/presentation/screens/attendance_regularization_screen.dart:24)
**Issue:** The screen toasts `state.successMessage`, but the bloc never sets `successMessage` (grep — zero writes). On `isSubmissionSuccess` the listener also separately toasts `l10n.submissionSuccess`, so the dead `successMessage` branch is just confusion.
**Fix:** Remove the `successMessage` field from state entirely, or actually populate it in the bloc and remove the duplicate `isSubmissionSuccess` toast.

#### B-5. Toasts re-fire on every unrelated state change (no `listenWhen` on screen listener)
**File:** [attendance_regularization_screen.dart:19-35](lib/features/attendance/presentation/screens/attendance_regularization_screen.dart:19)
**Issue:** The outer `BlocListener` has **no `listenWhen`**. Every state change (including `isUploading: true → false`, `isSubmitting: true → false`) will re-evaluate all four `if` branches. Because flags like `isFileUploadSuccess` and `isSubmissionSuccess` linger (see B-3), the toasts will repeat on subsequent emissions.
**Fix:** Add a `listenWhen` that only fires when the *transition* matters:
```dart
listenWhen: (prev, curr) =>
    (curr.errorMessage != null && curr.errorMessage != prev.errorMessage) ||
    (curr.isSubmissionSuccess && !prev.isSubmissionSuccess) ||
    (curr.isFileUploadSuccess && !prev.isFileUploadSuccess),
```
And in the bloc, **clear** `errorMessage`/`isSubmissionSuccess`/`isFileUploadSuccess` after they have been consumed (or convert them to one-shot side-effect events using a Stream/SnackBar queue).

#### B-6. `context` used after async gap in `_pickFile` without `mounted` check
**File:** [attendance_regularization_body.dart:129-146](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:129)
**Issue:** `_pickFile` does `await FilePicker.platform.pickFiles()`, then accesses `AppLocalizations.of(context)` (line 134) and `context.read<AttendanceRegularizationBloc>()` (line 139). If the user backs out during the picker, `context` may be unmounted — Flutter analyzer rule `use_build_context_synchronously` will flag this.
**Fix:** Capture the bloc and l10n **before** the await:
```dart
Future<void> _pickFile(BuildContext context) async {
  final bloc = context.read<AttendanceRegularizationBloc>();
  final l10n = AppLocalizations.of(context)!;
  final result = await FilePicker.platform.pickFiles();
  if (!mounted) return;
  // … then use bloc / l10n / setState
}
```

#### B-7. `_pickFile` does not validate `file.path` is non-null
**File:** [attendance_regularization_body.dart:141](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:141)
**Issue:** `file.path!` is force-unwrapped. On web, `FilePickerResult.files.first.path` is always `null` (web returns bytes only). This crashes on web.
**Fix:** Either (a) gate the entire feature with `if (kIsWeb) return;` and a friendly error toast, or (b) use `file.bytes` and switch to `MultipartFile.fromBytes` in the datasource.

#### B-8. `submitRegularization` payload logged in plain text (PII / privacy)
**File:** [attendance_remote_datasource.dart:272](lib/features/attendance/data/datasources/attendance_remote_datasource.dart:272)
**Issue:** `log('Submitting regularization: $payload')` ships in release builds (`dart:developer` `log` is not stripped). The payload includes `employee_remarks` (free-text reason that may contain PII) and attendance times.
**Fix:** Either remove the log entirely or wrap with `if (kDebugMode)`. Production logging should be done via the central `Logger` instance (already injected elsewhere), with a sanitized payload.

#### B-9. No client-side validation of business rules promised in guidelines
**Files:** [regularization_guidelines.dart](lib/features/attendance/presentation/widgets/regularization_guidelines.dart), [attendance_regularization_body.dart:76-103](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:76)
**Issue:** Guidelines tell the user:
- "Request must be raised within 5 days of the attendance date" → **not enforced** (date picker `firstDate: DateTime(2000)` allows any past date).
- "Both punch in and punch out times are required" → **not enforced** (`_submit` only validates `reason.length >= 10`; in/out controllers default to `--:--` and a request can be submitted with both empty, generating empty `requestedInTime`/`requestedOutTime` strings).
- "Only Absent or Half Day attendance can be regularized" → **not enforced** (no attendance-status check before allowing the form to render).
**Fix:** Move validation into the bloc (or a dedicated `ValidateRegularizationUseCase`):
```dart
if (DateTime.now().difference(date).inDays > 5) → emit error
if (inTime.isEmpty || outTime.isEmpty)         → emit error
if (parsedOut.isBefore(parsedIn))              → emit error
```
Also restrict `firstDate` in the date picker to `DateTime.now().subtract(const Duration(days: 5))`.

#### B-10. `Started` event has a parameter that's never wired and no handler
**File:** [attendance_regularization_event.dart:8](lib/features/attendance/presentation/bloc/attendance_regularization_event.dart:8), [attendance_regularization_bloc.dart:16-17](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart:16)
**Issue:** `AttendanceRegularizationEvent.started({required DateTime date}) = Started` is declared but **(a)** never dispatched anywhere in the codebase, **(b)** the bloc registers no `on<Started>(...)` handler, so dispatching it would throw `StateError: No handler registered for Started`. Worse: the public name `Started` collides with `attendance_event.dart:9` which also defines a top-level `Started` class — any file importing both blocs together will fail to compile.
**Fix:** Either remove the `Started` factory entirely, **or** rename to `RegularizationStarted` (skill rule: "Generated concrete class names must be PUBLIC and unique"). And register a handler if it has a real purpose, otherwise delete.

---

### 2.2 HIGH SEVERITY (H) — Architecture / skill-rule violations

#### H-1. Widget imports the data layer (cross-layer leak)
**File:** [attendance_regularization_body.dart:10-11](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:10)
**Rule violated:** Skill §1 "presentation/ may NOT import data/ directly".
**Issue:** Body imports `data/constants/attendance_api_constants.dart` to access `RegularizationRequestTypeConstants` and `RegularizationReason`. Same problem in [regularization_request_type.dart:6](lib/features/attendance/presentation/widgets/regularization_request_type.dart:6).
**Fix:** Move the request-type identifiers (`forgotToPunch`, `wrongPunchTime`, etc.) and the API reason categories (`Missed Punch`, etc.) into a domain-level constants file, e.g. `domain/entities/regularization_constants.dart` (or as a typed `enum RegularizationRequestType { forgotToPunch, … }` with an `apiCode` getter). The widget should know the *enum*, not the API string.

#### H-2. `_getReasonCategory` mapping lives in the widget
**File:** [attendance_regularization_body.dart:114-127](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:114)
**Rule violated:** Skill §2.4 "Screens are coordinators, not builders" + §9 "Business logic inside BLoC handler / widget".
**Issue:** The widget translates UI ids → API reason strings. This is business logic.
**Fix:** Encapsulate as a typed enum on the domain side and add `extension RegularizationRequestTypeApi on RegularizationRequestType { String get apiCode … }`. The widget then just emits the enum.

#### H-3. `_formatDateTime` formatting logic in widget
**File:** [attendance_regularization_body.dart:105-112](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:105)
**Issue:** Widget computes `combineDateAndTime(...)` and formats to API. Belongs in the bloc or a `BuildRegularizationPayloadUseCase` (or in the model's `fromEntity`).
**Fix:** Move formatting to the model/usecase. The widget should pass plain `DateTime`/`TimeOfDay` to the bloc.

#### H-4. `Body` widget owns submit/upload orchestration directly
**File:** [attendance_regularization_body.dart](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart)
**Rule violated:** Skill §2.4 "Widgets are dumb — they receive data and callbacks".
**Issue:** Body builds the `AttendanceRegularizationEntity`, talks to the BLoC, formats dates, validates reason length, and validates file size. Every one of those concerns should be split. The body should be thinner; consider promoting it back into the screen and extracting a `RegularizationFormController` (or putting form fields in BLoC state).
**Fix:** Move `_selectedDate`, `_requestType`, `_routeToHR`, and the three controllers' values into the BLoC state (as form fields). The widget binds controllers, dispatches `FieldChanged` events, and just renders. Validation runs in the bloc.

#### H-5. Repository swallows all exceptions with bare `catch (e)`
**File:** [attendance_repository_impl.dart](lib/features/attendance/data/repositories/attendance_repository_impl.dart) — every method (e.g. lines 23-26, 33-36, …)
**Rule violated:** Skill §2.1 "Catch `ServerException` → `ServerFailure`, `NetworkException` → `NetworkFailure`, `UnauthorizedException` → `UnauthorizedFailure`. **No other exception types should be caught silently.**"
**Issue:** Every method uses `catch (e) { return Left(Failure.fromException(e)); }`. This catches `OutOfMemoryError`, `StackOverflowError`, programmer errors, etc., and converts them into a generic failure — making bugs invisible.
**Fix:**
```dart
on ServerException catch (e)    { return Left(ServerFailure(e.message)); }
on UnauthorizedException        { return Left(UnauthorizedFailure()); }
on NetworkException catch (e)   { return Left(NetworkFailure(e.message)); }
```
Let everything else propagate. Apply across all 14 repo methods.

#### H-6. `submitRegularization` event contains a fully-built entity (UI builds the payload)
**File:** [attendance_regularization_event.dart:9-10](lib/features/attendance/presentation/bloc/attendance_regularization_event.dart:9), [attendance_regularization_body.dart:87-102](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:87)
**Issue:** Coupled to H-3/H-4. Event payload should be primitive form-fields, not a domain entity assembled in the widget.
**Fix:**
```dart
const factory AttendanceRegularizationEvent.submitRequested({
  required DateTime date,
  required RegularizationRequestType type,
  required TimeOfDay? inTime,
  required TimeOfDay? outTime,
  required bool routeToHR,
  required String reason,
}) = SubmitRequested;
```
Bloc constructs the entity, runs validation, calls the use case.

#### H-7. Bloc uses single state class with bool flags instead of sealed/union states
**File:** [attendance_regularization_state.dart](lib/features/attendance/presentation/bloc/attendance_regularization_state.dart)
**Rule violated:** Skill §2.3 "Use `@freezed` … `factory ... .loading() = LeaveLoading; factory ... .loaded() = LeaveLoaded;` — sealed union states with shared getters."
**Issue:** Current state is a single concrete class with five booleans (`isSubmitting`, `isUploading`, `isSubmissionSuccess`, `isFileUploadSuccess`, plus `errorMessage`, `successMessage`). This permits illegal combinations (e.g. `isSubmitting=true && isSubmissionSuccess=true`) and makes "transition-only" listeners harder.
**Fix:** Convert to a union:
```dart
@freezed
sealed class AttendanceRegularizationState with _$AttendanceRegularizationState {
  const factory AttendanceRegularizationState.idle({@Default(...) FormData form}) = _Idle;
  const factory AttendanceRegularizationState.uploading({...}) = _Uploading;
  const factory AttendanceRegularizationState.uploaded({...}) = _Uploaded;
  const factory AttendanceRegularizationState.submitting({...}) = _Submitting;
  const factory AttendanceRegularizationState.submitted() = _Submitted;
  const factory AttendanceRegularizationState.error(String message, FormData form) = _Error;
}
```
With a `FormData` value-object that survives across state copies.

#### H-8. No handler for `Started` (see B-10) and the bloc has only 2 handlers
**File:** [attendance_regularization_bloc.dart:16-17](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart:16)
**Issue:** Skill §2.3 says "Individual `on<ConcreteEventType>()` handler per event — never a single mega `on<FeatureEvent>`." Current code already follows this — but is missing handlers required by the form (FieldChanged, Reset, FileRemoved).
**Fix:** Add the missing handlers as part of H-7 refactor.

#### H-9. Bloc does not inject `LocalStorageService`
**File:** [attendance_regularization_bloc.dart:7-15](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart:7)
**Rule violated:** Skill §2.3 "Constructor injects use cases + `LocalStorageService` — never `SharedPreferences` or `IAuthRepository` directly. Read user identity from `LocalStorageService`."
**Issue:** No `localStorageService` is injected. The Frappe API likely infers `employee` from session, but if it doesn't, the request will fail silently. More importantly, downstream features (e.g., showing past requests, filtering) will need empId.
**Fix:** Inject `LocalStorageService` in the bloc constructor and DI registration ([dependency_injection.dart:454](lib/core/di/dependency_injection.dart:454)). Pass `empId` into the entity if required by the API.

#### H-10. Repository method `submitRegularization` doesn't pass `employee` field
**File:** [attendance_remote_datasource.dart:268-283](lib/features/attendance/data/datasources/attendance_remote_datasource.dart:268), [attendance_regularization_model.dart](lib/features/attendance/data/models/attendance_regularization_model.dart)
**Issue:** The Frappe doc payload includes `attendance_date`, `manual_in_time`, etc., but no `employee` field. This works only if the backend resolves the employee from the session cookie. Not portable, breaks if session is in a different role.
**Fix:** Add `@JsonKey(name: 'employee') required String employee` to `AttendanceRegularizationModel`, populate from `LocalStorageService.getEmpId()` in the bloc, propagate via the entity.

#### H-11. Datasource interface name violates `I` prefix convention
**File:** [attendance_remote_datasource.dart:10](lib/features/attendance/data/datasources/attendance_remote_datasource.dart:10)
**Rule violated:** Skill §1 example uses `I<Feature>RemoteDataSource`. Existing project examples (`ILeaveRepository`, `IAttendanceRepository`) confirm the rule.
**Issue:** `abstract class AttendanceRemoteDataSource` (no `I` prefix), implementation is `AttendanceRemoteDataSourceImpl`. Inconsistent with feature_generator skill.
**Fix:** Rename to `IAttendanceRemoteDataSource`. Update all DI and repository imports.

#### H-12. Magic numbers in widgets bypassing `AppConstants` / `AppTextStyle`
**Files:** Many — examples:
- [regularization_guidelines.dart:24](lib/features/attendance/presentation/widgets/regularization_guidelines.dart:24) `Icon(... size: 14)`
- [regularization_guidelines.dart:79](lib/features/attendance/presentation/widgets/regularization_guidelines.dart:79) `fontSize: 13`
- [regularization_guidelines.dart:38](lib/features/attendance/presentation/widgets/regularization_guidelines.dart:38) `SizedBox(height: 12)` (also: 8, repeatedly)
- [regularization_system_record.dart:75](lib/features/attendance/presentation/widgets/regularization_system_record.dart:75) `fontSize: 10`
- [regularization_system_record.dart:128](lib/features/attendance/presentation/widgets/regularization_system_record.dart:128) `fontSize: 10`
- [regularization_system_record.dart:138](lib/features/attendance/presentation/widgets/regularization_system_record.dart:138) `fontSize: 20`
- [regularization_request_type.dart:108-109](lib/features/attendance/presentation/widgets/regularization_request_type.dart:108) `fontSize: 12, height: 1.2`
- [regularization_request_type.dart:97-98](lib/features/attendance/presentation/widgets/regularization_request_type.dart:97) `size: 24`
- [regularization_request_type.dart:119-120](lib/features/attendance/presentation/widgets/regularization_request_type.dart:119) `width: 16, height: 16` and `width: 8, height: 8` — loose visual constants.
- [regularization_documents_section.dart:53](lib/features/attendance/presentation/widgets/regularization_documents_section.dart:53) `size: 48`
- [regularization_details_section.dart:33](lib/features/attendance/presentation/widgets/regularization_details_section.dart:33) `width: 4` (border), `padding: EdgeInsets.only(left: 12)`
- [regularization_action_buttons.dart:61](lib/features/attendance/presentation/widgets/regularization_action_buttons.dart:61) `blurRadius: 16, offset: Offset(0, 8)`
**Rule violated:** Skill §2.4 "Use `const` constructors wherever possible" + §3 "Text styles … no hex literals … `.copyWith()` to adjust only specific properties" — but here `.copyWith(fontSize: 10)` defeats the design system.
**Fix:** Either (a) add the missing sizes to `AppConstants` (`size10`, `size12`, etc.) and `AppTextStyle` (`labelMicro`, `bodyXLarge`, …), (b) use the existing scale from theme, or (c) accept these as widget-local constants but pull them to a `const _kBadgeSize = 16.0;` at the top of each file. Same finding applies to `SizedBox` heights (8, 12, 20) used inline — group them through `AppConstants.p4 / p6 / p8 / p10 / p12 / p20`.

#### H-13. `Colors.transparent`, `Colors.black12` — hardcoded colors
**Files:**
- [regularization_request_type.dart:83](lib/features/attendance/presentation/widgets/regularization_request_type.dart:83) `Colors.transparent`
- [regularization_documents_section.dart:105](lib/features/attendance/presentation/widgets/regularization_documents_section.dart:105) `Colors.black12`
- [regularization_action_buttons.dart:67](lib/features/attendance/presentation/widgets/regularization_action_buttons.dart:67) `Colors.transparent`
**Rule violated:** Skill §3 / §9 "Hardcoded color `Color(0xFF...)` in a widget — use `AppColors.*`."
**Fix:** Add `AppColors.transparent` (just `Color(0x00000000)`) and `AppColors.shadowSoft` and reference from there.

#### H-14. Mixed deprecated `withOpacity` / `withValues`
**Files (occurrences of `withOpacity` — Flutter 3.27+ deprecation):**
- [regularization_action_buttons.dart:60](lib/features/attendance/presentation/widgets/regularization_action_buttons.dart:60)
- [regularization_date_picker.dart:76](lib/features/attendance/presentation/widgets/regularization_date_picker.dart:76)
- [regularization_details_section.dart:69](lib/features/attendance/presentation/widgets/regularization_details_section.dart:69)
- [regularization_guidelines.dart:16](lib/features/attendance/presentation/widgets/regularization_guidelines.dart:16)
**Issue:** `Color.withOpacity(double)` is deprecated; the same files mix `.withValues(alpha: …)` and `.withOpacity(…)`.
**Fix:** Convert all to `.withValues(alpha: …)` — verify with `flutter analyze`.

#### H-15. `routeToHRSub` text is rendered with `AppColors.onSecondaryFixedVariant` despite background being `primaryFixed`
**File:** [regularization_details_section.dart:97](lib/features/attendance/presentation/widgets/regularization_details_section.dart:97)
**Issue:** Color pair likely fails contrast accessibility (`onPrimaryFixed` is the proper "on" color for `primaryFixed` background). Verify via Material 3 token mapping.
**Fix:** Change to `AppColors.onPrimaryFixedVariant` (or whichever the design tokens specify for "subtitle on primaryFixed background").

#### H-16. `Border.all(... style: BorderStyle.none)` is a no-op
**File:** [regularization_documents_section.dart:40-43](lib/features/attendance/presentation/widgets/regularization_documents_section.dart:40)
**Issue:** Setting `style: BorderStyle.none` while still passing a color makes the call do nothing — the BoxDecoration ignores the border. Either drop the border or use a dashed/visible border (matches Figma's typical "drop-zone" pattern).
**Fix:** If a dashed/dotted upload-zone border is intended (common in design specs), use `dotted_border` package. Otherwise remove the `border` argument entirely.

#### H-17. `_RequestTypeItem.color` field set but never read
**File:** [regularization_request_type.dart:171](lib/features/attendance/presentation/widgets/regularization_request_type.dart:171)
**Issue:** All four items pass `color: AppColors.primary`, but the field is never read anywhere in the build (`type.icon` and `type.label` are read; `type.color` is not). Dead field.
**Fix:** Either remove the field, or actually use it for icon/border tint per type.

#### H-18. `_isDateSelected` is redundant with `_selectedDate != null`
**File:** [attendance_regularization_body.dart:44, 71, 173](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:44)
**Issue:** Two sources of truth for the same condition.
**Fix:** Drop `_isDateSelected`; use `_selectedDate != null`.

#### H-19. `didChangeDependencies` initializes default `_requestType` — should be `initState`
**File:** [attendance_regularization_body.dart:55-61](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:55)
**Issue:** `didChangeDependencies` runs on every locale or theme change. Initializing default state once belongs in `initState` (the check `_requestType.isEmpty` guards it but the call still wastes lifecycle slots).
**Fix:** Move to `initState`:
```dart
@override
void initState() {
  super.initState();
  _requestType = RegularizationRequestTypeConstants.forgotToPunch;
}
```

---

### 2.3 MEDIUM (M)

#### M-1. `RegularizationDocumentsSection` shows `uploadedFileUrl` as raw URL
**File:** [regularization_documents_section.dart:77](lib/features/attendance/presentation/widgets/regularization_documents_section.dart:77)
**Issue:** Once uploaded, the displayed text is the full server URL (`/files/foo.pdf`), not the original `selectedFileName`. UX-wise the user expects to see the filename they picked.
**Fix:** Show `selectedFileName ?? Uri.parse(uploadedFileUrl!).pathSegments.last`.

#### M-2. File picker accepts any file type
**File:** [attendance_regularization_body.dart:130](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:130)
**Issue:** `FilePicker.platform.pickFiles()` defaults to `FileType.any`. Backend likely expects images/PDFs.
**Fix:** Add a constant in [app_constants.dart](lib/core/constants/app_constants.dart) for allowed types and pass `type: FileType.custom, allowedExtensions: ['pdf','png','jpg','jpeg']`.

#### M-3. 10 MB limit is hardcoded
**File:** [attendance_regularization_body.dart:133](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:133)
**Rule violated:** Skill §4 "Zero-tolerance magic numbers."
**Fix:** Add `static const int maxAttachmentBytes = 10 * 1024 * 1024;` to `AppConstants` and reference.

#### M-4. Date picker `firstDate: DateTime(2000)` is excessive
**File:** [regularization_date_picker.dart:44](lib/features/attendance/presentation/widgets/regularization_date_picker.dart:44)
**Issue:** Allows selecting attendance dates in the year 2000 — incompatible with the 5-day rule (B-9).
**Fix:** Use `DateTime.now().subtract(const Duration(days: AppConstants.regularizationWindowDays))` once the constant is defined.

#### M-5. Unhelpful default times sent as empty strings
**Files:** [attendance_regularization_body.dart:36-41, 105-112](lib/features/attendance/presentation/widgets/attendance_regularization_body.dart:36)
**Issue:** Controllers default to `--:--`. `_formatDateTime` returns `""` if the value equals the placeholder, so the API receives `manual_in_time: ""` and `manual_out_time: ""`. Frappe will likely accept this and create an invalid record.
**Fix:** Validate non-empty in/out before submit (see B-9).

#### M-6. `RegularizationSystemRecord` always shows "Incomplete" badge
**File:** [regularization_system_record.dart:60-78](lib/features/attendance/presentation/widgets/regularization_system_record.dart:60)
**Issue:** Hardcoded `l10n.incomplete` badge; no input describing actual punch state. The widget receives only `selectedDate`, but the Figma intent is to show the *real* system-recorded punch in/out for that date.
**Fix:** Either remove this widget entirely until the backend exposes a "system punches for date X" endpoint, or wire it to such an endpoint via a new use case `GetSystemPunchesForDateUseCase`. As-is it's a static placeholder that misleads QA.

#### M-7. `Theme(... InputDecorationTheme())` wrapper is a hack
**Files:** [regularization_date_picker.dart:46-53](lib/features/attendance/presentation/widgets/regularization_date_picker.dart:46), [regularization_details_section.dart:170-177](lib/features/attendance/presentation/widgets/regularization_details_section.dart:170)
**Issue:** Wrapping the picker in `Theme(data: …copyWith(inputDecorationTheme: const InputDecorationTheme()))` blanks out the form decoration globally for the picker dialog. Likely a workaround for some default styling that should instead be configured in the global `AppTheme`.
**Fix:** Remove the wrapper; if the picker still looks wrong, fix `AppTheme.inputDecorationTheme` properly.

#### M-8. `regularizationGuidelines` title is `.toUpperCase()`'d in code instead of stored as such
**File:** [regularization_guidelines.dart:27](lib/features/attendance/presentation/widgets/regularization_guidelines.dart:27)
**Issue:** Hindi (`नियमितीकरण दिशानिर्देश`) cannot be uppercased. The `.toUpperCase()` is a no-op in Hindi but visually inconsistent with the EN render.
**Fix:** Either (a) store the upper-cased English variant in the ARB and a normal-case Hindi variant, or (b) remove `.toUpperCase()` and use `letterSpacing` only. Same issue at [regularization_system_record.dart:47](lib/features/attendance/presentation/widgets/regularization_system_record.dart:47), [regularization_details_section.dart:154](lib/features/attendance/presentation/widgets/regularization_details_section.dart:154), [regularization_system_record.dart:71](lib/features/attendance/presentation/widgets/regularization_system_record.dart:71).

#### M-9. `RegularizationRequestType` rebuilds the `types` list on every build
**File:** [regularization_request_type.dart:22-47](lib/features/attendance/presentation/widgets/regularization_request_type.dart:22)
**Issue:** Allocations every frame. Not catastrophic but wasteful.
**Fix:** Move the static portions (id/icon/color) to a top-level `const` list; resolve the localized label inside the `itemBuilder`.

#### M-10. Bloc clears `errorMessage` on every event but never on user dismissal
**File:** [attendance_regularization_bloc.dart:25-30](lib/features/attendance/presentation/bloc/attendance_regularization_bloc.dart:25)
**Issue:** Once an error is shown via toast, it sits in state until the next event. With B-5 fixed via `listenWhen`, this is OK; but a cleaner approach is one-shot side effects.
**Fix:** Consider Bloc `Stream<Effect>` pattern (see `flutter_bloc` examples).

#### M-11. `attendance_regularization_event.freezed.dart` and `attendance_regularization_state.freezed.dart` not validated by this review
**Note:** Generated files were not opened; assume `dart run build_runner build` keeps them in sync. Run the build before any commit.

#### M-12. Missing `equatable`/freezed on bloc state would matter — but state IS freezed (good)
**File:** [attendance_regularization_state.dart](lib/features/attendance/presentation/bloc/attendance_regularization_state.dart)
**Note:** Acceptable. No fix needed.

#### M-13. DI registration uses interface but not the cleanest order
**File:** [dependency_injection.dart:274-281, 454-460](lib/core/di/dependency_injection.dart:274)
**Note:** Skill §6 says register in order: DataSource → Repository → UseCase → Bloc. Current registrations follow this order — good. Just verify after H-11 rename that the interface name updates in DI too.

#### M-14. `attendance_repository_impl.dart` constructor uses positional params
**File:** [attendance_repository_impl.dart:14](lib/features/attendance/data/repositories/attendance_repository_impl.dart:14)
**Issue:** `AttendanceRepositoryImpl(this.remoteDataSource, this.networkInfo);` — positional. Skill examples use named (`{required this.x}`). Inconsistent with `LeaveRepositoryImpl` style guidance.
**Fix:** Convert to named parameters for safer call sites in DI.

#### M-15. `attendance_remote_datasource.dart` constructor positional
**File:** [attendance_remote_datasource.dart:53](lib/features/attendance/data/datasources/attendance_remote_datasource.dart:53)
**Issue:** Same as M-14. Also missing injected `Logger` (skill §2.1: "Do NOT use `debugPrint` — use the injected `Logger`."). The `log()` call at line 272 uses `dart:developer`; should be the central `Logger`.
**Fix:** Inject `Logger` and use that for the (now sanitized, see B-8) submission log.

#### M-16. `Failure.fromException(e)` (verify the helper covers all cases)
**Files:** repository (every method)
**Note:** Verify [core/error/failures.dart] correctly maps `DioException`, `SocketException`, `FormatException`, `TypeError`, etc. Outside the scope of this review but a likely source of poor error messages.

---

### 2.4 LOW (L)

- **L-1.** [attendance_regularization_screen.dart:42-45](lib/features/attendance/presentation/screens/attendance_regularization_screen.dart:42) — back-arrow color is `AppColors.primaryContainer`. Verify against Figma; likely should be `AppColors.onSurface`.
- **L-2.** [attendance_regularization_screen.dart:54](lib/features/attendance/presentation/screens/attendance_regularization_screen.dart:54) — body padding lives inside the body widget (`SingleChildScrollView` padding); consider hoisting to the screen so the appbar is flush.
- **L-3.** Inconsistent `.copyWith(fontWeight: FontWeight.bold)` vs `FontWeight.w900` vs `FontWeight.w600` — pick a scale and add tokens to `AppTextStyle`.
- **L-4.** [regularization_action_buttons.dart:46-95](lib/features/attendance/presentation/widgets/regularization_action_buttons.dart:46) — could be replaced with the existing `PrimaryGradientButton` shared widget if one exists. Otherwise extract this gradient button into `shared/widgets/`.
- **L-5.** Add a [const] in front of widget constructors where possible to allow tree-shake / canvas batching (most are already const — good).
- **L-6.** No tests exist for the regularization flow. At minimum, add unit tests for: `AttendanceRegularizationModel.fromEntity` round-trip, `AttendanceRegularizationBloc.SubmitRequested` happy path + failure path, and the validation rules added in B-9.
- **L-7.** [regularization_documents_section.dart:97-148](lib/features/attendance/presentation/widgets/regularization_documents_section.dart:97) — the un-uploaded branch renders a circle + label + button; consider extracting `_EmptyDropZone`/`_UploadedDropZone` private widgets for clarity.
- **L-8.** `attendance_regularization_screen.dart` uses `AppBar`'s default `Theme` brightness — make sure status bar styling is OK on both light/dark.

---

## 3. Skill / README compliance scoreboard

| Skill rule | Status | Notes |
|---|---|---|
| Folder layout (§1) | ✅ | data/domain/presentation correct |
| `presentation/` ↛ `data/` rule (§1) | ❌ | H-1: body imports data constants |
| Models `@freezed` + `@JsonSerializable` + `toEntity()` (§2.1) | ✅ | Good model |
| Datasource interface + impl (§2.1) | ⚠️ | Names lack `I` prefix (H-11) |
| No `Content-Type` set in datasource (§2.1) | ✅ | Not set |
| No manual statusCode check (§2.1) | ✅ | Not present |
| Use injected `Logger` (§2.1) | ❌ | Datasource uses `dart:developer log` (M-15) |
| Repo wraps `networkInfo.connectedAndRun` (§2.1) | ✅ | All methods wrap |
| Repo catches typed exceptions (§2.1) | ❌ | Bare `catch (e)` everywhere (H-5) |
| Entity is pure Dart (§2.2) | ✅ | Equatable-based |
| Repo interface `I*` prefix (§2.2) | ✅ | `IAttendanceRepository` |
| Single-method UseCase (§2.2) | ✅ | Good |
| Public freezed event names (§2.3) | ⚠️ | `Started` collides with `attendance_event.dart`'s `Started` (B-10) |
| `on<Concrete>` per event (§2.3) | ✅ | Good |
| Inject `LocalStorageService` (§2.3) | ❌ | Bloc lacks it (H-9) |
| Use `dart:developer log` (§2.3) | ✅ | Bloc has none — fine |
| Sealed-union state (§2.3) | ❌ | Single class with bool flags (H-7) |
| Screen as coordinator only (§2.4) | ❌ | Body widget owns business logic (H-2/H-3/H-4) |
| Widget ↛ data layer (§2.4) | ❌ | Body imports data constants (H-1) |
| `AppColors`/`AppTextStyle`/`AppConstants` only (§3) | ❌ | Magic sizes/colors (H-12, H-13) |
| `AppLocalizations` for user strings (§5) | ✅ | All strings keyed; both EN and HI ARBs synced |
| `StorageConstants` for prefs (§3) | n/a | None used |
| Status codes as constants (§4) | ❌ | `'Save'`/`'Submit'` hardcoded (B-1); `routedToHr: 1`/`0` magic (M minor) |
| DI lazyPut + fenix (§6) | ✅ | Both use cases + bloc registered correctly |
| Route added (§7) | ✅ | `/attendance-regularization` registered |
| `dart run build_runner` (§8) | ⚠️ | Run after applying fixes |
| Anti-patterns (§9) | ❌ | Multiple — see findings |

---

## 4. Suggested fix order (when handing this to an AI)

1. **Phase 1 — Data correctness (Blockers):** B-1, B-9, B-10, B-7, B-6, B-8.
2. **Phase 2 — State integrity:** B-2, B-3, B-4, B-5, H-7, H-8, H-9, H-10.
3. **Phase 3 — Architecture cleanup:** H-1, H-2, H-3, H-4, H-5, H-6, H-11, H-15, H-19.
4. **Phase 4 — Polish / design system:** H-12, H-13, H-14, H-16, H-17, H-18, all M-* items.
5. **Phase 5 — Verification:**
   - `dart run build_runner build --delete-conflicting-outputs`
   - `flutter analyze` → zero new warnings
   - Manual smoke: pick date → toggle each request type → upload file → delete file → resubmit → confirm draft becomes Submitted in Frappe.
   - Add unit tests for bloc + model (L-6).

---

## 5. Open questions for the requester (must answer before automated fix)

1. **Frappe action contract:** is the intent for "Submit Request" to create a Submitted (`docstatus=1`) doc, or just save as draft? (Drives B-1.)
2. **System Record widget:** is there an API endpoint that returns the actual punch in/out for a given date? If not, this widget should be removed pending backend work (M-6).
3. **Web support:** does the app target Flutter Web? If yes, B-7 needs the bytes-based path.
4. **HR routing flow:** when `route_to_hr = 1`, what is the expected workflow on the backend? (Affects whether this is a checkbox or a separate doctype.)
5. **5-day rule:** the guidelines text says "within 5 days." Confirm; client will enforce this once known.
6. **Graphify:** is the tool internally distributed? Provide install instructions or remove the rule from `CLAUDE.md`.

---

*End of report.*

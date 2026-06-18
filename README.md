# Dhira HRMS - Clean Architecture Flutter Project

A modern, scalable Human Resource Management System (HRMS) built with Flutter, following standard **Clean Architecture** principles and **MVVM + BLoC** state management.

---

## 🏗 Architecture & State Management Philosophy

This project is built on two primary foundations: **Clean Architecture** and **BLoC State Management**. Here is the "Why" behind these strategic choices:

### **Why Clean Architecture?**
We use a modular interpretation of Clean Architecture to achieve:
- **Independence**: The `domain` layer (business logic) is completely isolated from external frameworks, databases, and UI components.
- **Testability**: Business rules can be thoroughly tested in isolation without needing a UI or a server.
- **Maintenance**: Clear boundaries between layers ensure that changes in one part of the app (e.g., UI redesign) have minimal impact on others (e.g., repository logic).
- **Scalability**: New features can be added by following the established Data-Domain-Presentation pattern without bloating existing modules.

### **Why BLoC (Business Logic Component)?**
BLoC is our chosen state management solution because it provides:
- **Predictability**: State changes are driven exclusively by events, ensuring a "Single Source of Truth" and predictable transitions.
- **Decoupling**: The UI is a pure reflection of the current state; it doesn't contain business logic, making it easier to swap or redesign.
- **Reliability**: BLoC is exceptionally well-suited for the complex, non-linear workflows typical of an HRMS (e.g., multi-step auth, complex leave eligibility rules).
- **Consistency**: Centralized state management makes debugging significantly faster, especially when using the `BlocObserver`.

---

## 🏗 Core Architecture & Implementation Guide

This project follows a strict separation of concerns through modular layers. New developers should adhere to the following implementation patterns:

### **1. Dependency Injection (DI)**
We use the `Get` package as our primary Service Locator. It decouples architectural layers by managing object lifecycles.

#### **Registration Types**
- **Lazy Singleton (Recommended)**: Initializes only when first accessed.
  ```dart
  Get.lazyPut<IAuthRepository>(() => AuthRepositoryImpl(), fenix: true);
  ```
  > [!TIP]
  > **`fenix: true`** is crucial. It ensures that if a dependency is disposed (e.g., when a feature module's last screen is closed), GetX will automatically recreate it when requested again.

- **Immediate Singleton**: Initializes as soon as the app starts (use for core services like `Logger` or `Storage`).
  ```dart
  Get.put<Logger>(Logger());
  ```

- **Factory (New Instance Always)**: Returns a fresh instance every time `Get.find<T>()` is called.
  ```dart
  Get.create<MyService>(() => MyService());
  ```

#### **How to Register**
All registrations must be added to the `init()` method in [dependency_injection.dart](lib/core/di/dependency_injection.dart).

#### **How to Use**
Retrieve any dependency anywhere in the app using:
```dart
final authRepo = Get.find<IAuthRepository>();
```

### **2. Network Resilience Layer**
The network layer is designed for both **Proactive** and **Reactive** reliability:

- **Proactive Connectivity**: Every repository method uses the `networkInfo.connectedAndRun(...)` functional wrapper. This extension (defined in `core/network/network_info.dart`) verifies internet status *before* initiating an API call, returning a `NetworkFailure` immediately if offline.
- **Reactive Session Handling**: The `AuthInterceptor` monitors all traffic. If a `401 Unauthorized` is detected, it triggers the `SessionManager.triggerSessionExpired()` broadcast.
- **Global Redirect**: `main.dart` listens to this broadcast and automatically navigates the user back to the Login screen, ensuring no stale sessions remain active.

### **3. Proactive Route Protection**
Navigation is managed by `GoRouter` with a centralized `redirect` handler in [app_router.dart](lib/core/routing/app_router.dart). 
- It proactively checks `IAuthRepository.isSessionActive()` before every state change.
- It prevents unauthorized access to protected routes (like `/dashboard`) and prevents authenticated users from redundantly accessing the `/login` screen.

### **4. Feature Anatomy**
When building a new feature, follow this implementation order:
1. **Data Layer**: Define `ApiConstants`, `Model` (JsonSerializable), `RemoteDataSource`, and `RepositoryImpl`.
2. **Domain Layer**: Define `Entity`, `Repository Interface`, and `UseCase`.
3. **Presentation Layer**: Implement `BLoC` (Events/States) and finally the `Screen` UI.

---

## 📂 Folder Structure

```text
lib/
├── core/                   # Shared logic, constants, and global services
│   ├── di/                 # Dependency Injection registry
│   ├── network/            # DioClient, Interceptors, SessionManager, NetworkInfo
│   ├── routing/            # AppRouter (GoRouter with redirect logic)
│   ├── theme/              # AppTheme, Colors, Typography
│   ├── error/              # Domain Failures & Exceptions
│   └── utils/              # Formatting (Date, Toast) and Extensions
├── features/               # Independent feature modules (isolated)
│   ├── <feature_name>/     # Example: leave, attendance, auth
│   │   ├── data/           # Data Layer (Retrieval & Persistence)
│   │   │   ├── constants/  # Feature-specific API endpoints (e.g., LeaveApiConstants)
│   │   │   ├── datasources/# Remote (API) and Local (Cache) data sources
│   │   │   ├── models/     # Data models for JSON mapping (with toEntity() methods)
│   │   │   └── repositories/# Repository implementations (calls data sources)
│   │   ├── domain/         # Domain Layer (Pure Business Logic)
│   │   │   ├── entities/   # Plain Dart objects used in BL and UI
│   │   │   ├── repositories/# Domain-level repository interfaces
│   │   │   └── usecases/   # Feature-specific business rules (Single Responsibility)
│   │   └── presentation/   # Presentation Layer (UI & State)
│   │       ├── bloc/       # BLoC/Cubit for state management (Events/States)
│   │       ├── screens/    # Full-page feature views
│   │       └── widgets/    # Components unique to this feature
├── shared/                 # Reusable UI components (Dialogs, Toasts)
└── l10n/                   # Localization support (EN, HI)
```

---

## 🛠 Plugin Registry & Rationale

| Plugin | Version | Purpose in DHIRA HRMS |
|:---|:---|:---|
| `dio` | `^5.9.2` | Core HTTP client. Used for its powerful interceptor support (Auth & Logging). |
| `flutter_bloc` | `^9.1.1` | Core state management. Ensures predictable state transitions for complex features. |
| `get` | `^4.7.3` | Used strictly for Dependency Injection (DI) to decouple architectural layers. |
| `go_router` | `^17.1.0` | Declarative routing with deep-link support and proactive session gatekeeping. |
| `connectivity_plus`| `^7.1.0` | Real-time network monitoring used by `NetworkInfo` for pre-flight API checks. |
| `dartz` | `^0.10.1` | Functional programming library used for `Either<Failure, T>` return types. |
| `shared_preferences`| `*` | Persistent local storage for session cookies and basic user preferences. |
| `logger` | `^2.7.0` | Standardized, pretty-print logging for debugging network and state changes. |
| `package_info_plus`| `^9.0.1` | Retrieves app version and build info for mandatory API platform headers. |
| `equatable` | `^2.0.8` | Simplifies object comparison, essential for BLoC state change detection. |
| `freezed` | `^3.2.5` | Code generation for immutable state and union classes (Data/Domain models). |

---

## 🚀 Getting Started

1. **Clone & Install**: `flutter pub get`
2. **Generate Models & Localization**: 
   ```bash
   # Generate freezed/json_serializable models
   flutter pub run build_runner build --delete-conflicting-outputs
   # Generate localizations (since generated l10n files are ignored in git)
   flutter gen-l10n
   ```
3. **Run**: `flutter run`

---

## 🎨 UI & Design Principles
- **Aesthetics**: Premium modern design (Glassmorphism, gradients, micro-animations).
- **Consistency**: All colors must use `AppColors`. All text must use `AppTextStyles`.
- **Feedback**: Non-blocking feedback should use `ToastUtils`; critical errors should use `AppDialogs`.

---

## 🤖 Master Feature Development Prompt

Copy and use the following prompt with an AI coding assistant (like Antigravity or ChatGPT) to generate new features or updates that strictly follow this project's architecture.

### **The Prompt Template**

```text
You are a Senior Flutter Developer. Your task is to [CREATE/UPDATE] a feature for the Dhira HRMS project.

[INPUT SOURCE]
I have attached [SCREENSHOTS / CODE SNIPPETS / UI DESIGN] to this request. Use them as the primary source of truth for the UI and logic.

[CORE CONSTRAINTS]
1. ARCHITECTURE: Strictly follow the Clean Architecture (Data -> Domain -> Presentation) as described in the project's README.md.
2. STATE MANAGEMENT: Use BLoC (flutter_bloc) for all presentation logic. UI must be a pure reflection of BLoC states.
3. DATA RESILIENCE: Every repository method MUST use the `networkInfo.connectedAndRun(...)` wrapper for pre-flight connectivity checks.
4. FUNCTIONAL TYPES: Use Dartz `Either<Failure, T>` for all Repository and UseCase return types.
5. DI: Dependencies MUST be registered in `lib/core/di/dependency_injection.dart` using GetX. Use `Get.lazyPut(..., fenix: true)` for repositories/usecases.
6. UI PRINCIPLES: Use Glassmorphism, AppColors, and AppTextStyles. Never use hardcoded colors or text styles.
7. NAMING: Follow the existing naming convention (e.g., IFeatureRepository, FeatureRepositoryImpl, FeatureRemoteDataSource).

[REQUIRED OUTPUT]
Generate the following files for the feature '[FEATURE_NAME]':
1. DATA: Model (JsonSerializable/Freezed), RemoteDataSource (Interface & Impl), Repository (Impl).
2. DOMAIN: Entity, Repository (Interface), UseCases.
3. PRESENTATION: BLoC (Events, States, Bloc class), Screens (UI), Widgets.
4. DI: Provide the exact code to be added to `dependency_injection.dart`.

Review the project's README.md and existing features (like 'auth' or 'leave') to ensure code consistency before generating.
```

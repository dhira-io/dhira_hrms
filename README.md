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
We use the `Get` package as a lightweight service locator. 
- **Registration**: All services, data sources, and repositories are registered in [dependency_injection.dart](lib/core/di/dependency_injection.dart).
- **Usage**: Use `Get.find<T>()` to retrieve dependencies. 
- **Fenix mode**: Most `lazyPut` registrations use `fenix: true` to ensure they are recreated if disposed by the framework.

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
2. **Generate Models**: 
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. **Run**: `flutter run`

---

## 🎨 UI & Design Principles
- **Aesthetics**: Premium modern design (Glassmorphism, gradients, micro-animations).
- **Consistency**: All colors must use `AppColors`. All text must use `AppTextStyles`.
- **Feedback**: Non-blocking feedback should use `ToastUtils`; critical errors should use `AppDialogs`.

# Dhira HRMS - Clean Architecture Flutter Project

A modern, scalable Human Resource Management System (HRMS) built with Flutter, following the **Clean Architecture** principles and **MVVM + BLoC** state management.

## 🏗 Architecture & Design

This project is built using a modular and testable architecture, ensuring high maintainability and scalability.

### **Layers**
- **Domain Layer**: The heart of the application. Contains Business Logic (UseCases), Domain Entities, and Repository Interfaces. No dependencies on outer layers.
- **Data Layer**: Responsible for data retrieval and persistence. Contains Repository Implementations, Data Sources (Remote/Local), and Data Models (JSON mapping).
- **Presentation Layer**: The UI layer. Uses **BLoC/Cubit** for reactive state management, providing a clear separation between logic and widgets.

### **Key Components**
- **Modular Network Layer**: Powered by `Dio`, with custom interceptors for:
    - `AuthInterceptor`: Centralized cookie management and platform header injection (Build Version, OS, Timezone).
    - `LoggingInterceptor`: Comprehensive network request/response logging via the standard `Logger`.
- **Reactive Session Management**: Uses a centralized `SessionManager` and `SessionExpiredStream` to handle `401 Unauthorized` responses globally.
- **Dependency Injection**: Orchestrated using the `Get` package for efficient service and repository registration.
- **Responsive Routing**: Managed with `GoRouter` for deep-linking and stateful navigation.
- **Rich Aesthetics**: Custom design system using `AppColors` (curated palettes), `AppAssets`, and `AppTextStyles`.

---

## 📂 Folder Structure

```text
lib/
├── core/               # Shared logic, constants, and global services
│   ├── di/             # Dependency Injection registration
│   ├── network/        # DioClient, Interceptors, SessionManager
│   ├── routing/        # AppRouter (GoRouter)
│   ├── theme/          # AppColors, AppTheme, AppTextStyles
│   ├── error/          # Domain-specific Exceptions & Failures
│   └── utils/          # Formatting and UI helpers
├── features/           # Independent feature modules
│   ├── auth/           # Login, Session Management, Microsoft SSO
│   ├── attendance/     # Check-in/out, History, Calendar
│   ├── leave/          # Leave Requests, Balance, Approvals
│   ├── timesheet/      # Timesheet Apply/Update, Projects
│   ├── profile/        # User Profile, Avatar Update, Changes
│   └── dashboard/      # Main Hub and Navigation
├── shared/             # Reusable global widgets and dialogs
└── l10n/               # Localization support (EN, HI)
```

---

## 🛠 Tech Stack

- **Framework**: Flutter
- **State Management**: flutter_bloc (BLoC/Cubit)
- **HTTP Client**: Dio
- **Navigation**: GoRouter
- **Persistence**: SharedPreferences / SecureStorage
- **Dependency Injection**: Get (LazyPut)
- **Icons & UI**: Cupertino & Material Design
- **Connectivity**: ConnectivityPlus
- **Dev Tools**: Freezed, JsonSerializable (BuildRunner)

---

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (>= 3.9.0)
- Dart SDK
- Android Studio / VS Code

### **Setup**
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Generate boilerplate code (if using Freezed/JsonSerializable):
    ```bash
    flutter packages pub run build_runner build --delete-conflicting-outputs
    ```
4. Run the project:
    ```bash
    flutter run
    ```

---

## 🎨 UI Guidelines
- Use `AppColors` for all theming to maintain consistency.
- Prefer **Vanilla CSS-style layouts** within Flutter (Flex, Column, Row) with modern, premium aesthetics (Glassmorphism, subtle gradients, and micro-animations).
- All hardcoded assets must be referenced via the `AppAssets` class.

import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/leave/presentation/bloc/leave_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'l10n/app_localizations.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/bloc/locale_cubit.dart';
import 'core/network/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Global Dependency Injection
  await DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Listen for global session expiration
    Get.find<SessionManager>().sessionExpiredStream.listen((_) {
      // Clear navigation stack and go to sign in
      AppRouter.router.go('/signin');
    });
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        /// 🌍 Locale Cubit
        BlocProvider(
          create: (_) => Get.find<LocaleCubit>(),
        ),

        /// 🕒 TEMP Attendance Bloc (required to avoid crash)
        BlocProvider(create: (_) => Get.find<AuthBloc>()),
        BlocProvider(create: (_) => Get.find<AttendanceBloc>()),
        BlocProvider(create: (_) => Get.find<LeaveBloc>()),
        BlocProvider(create: (_) => Get.find<TimesheetBloc>()),
        BlocProvider(create: (_) => Get.find<ProfileBloc>()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'DHIRA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
            ],
          );
        },
      ),
    );
  }
}


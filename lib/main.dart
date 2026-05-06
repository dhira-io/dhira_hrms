import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/services/deep_link_service.dart';
import 'features/auth/presentation/bloc/login_cubit.dart';
import 'features/auth/presentation/bloc/sso_cubit.dart';
import 'l10n/app_localizations.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/bloc/locale_cubit.dart';
import 'core/bloc/theme_cubit.dart';
import 'core/network/session_manager.dart';

// ≡ƒöÑ BLoCs
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/leave/presentation/bloc/leave_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'features/timesheet/presentation/bloc/timesheet_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

    /// ≡ƒöÑ Session Expired Handling
    Get.find<SessionManager>().sessionExpiredStream.listen((_) {
      AppRouter.router.go('/signin');
    });

    /// 🔗 Deep Link Handling (Microsoft SSO)
    Get.find<DeepLinkService>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        /// ≡ƒîì Locale
        BlocProvider<LocaleCubit>(
          create: (_) => Get.find<LocaleCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => Get.find<ThemeCubit>(),
        ),

        /// ≡ƒöÉ GLOBAL AUTH BLOC (ONLY ONCE)
        BlocProvider<AuthBloc>.value(
          value: Get.find<AuthBloc>()
            ..add(const AuthEvent.started()),
        ),

        BlocProvider<LoginCubit>(
          create: (_) => Get.find<LoginCubit>(),
        ),

        BlocProvider(create: (_) => Get.find<SSOCubit>()),

        BlocProvider<AttendanceBloc>(
          create: (_) => Get.find<AttendanceBloc>(),
        ),
        
        BlocProvider<LeaveBloc>(
          create: (_) => Get.find<LeaveBloc>(),
        ),

        BlocProvider<ProfileBloc>(
          create: (_) => Get.find<ProfileBloc>(),
        ),
        
        BlocProvider<TimesheetBloc>(
          create: (_) => Get.find<TimesheetBloc>(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'DHIRA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: locale,

            /// 🌐 Localization
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('hi')],
          );
        },
      ),
    );
  }
}

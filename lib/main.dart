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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/services/notification_manager.dart';



// ≡ƒöÑ BLoCs
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';
import 'features/notifications/presentation/bloc/notification_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await DependencyInjection.init();

  // Initialize Notification Manager
  await NotificationManager().init();

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
      final context = AppRouter.navigatorKey.currentContext;
      if (context != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('Session Expired'),
            content: const Text('Your session has expired. Please log in again.'),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.forcedLogoutRequested());
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      } else {
        Get.find<AuthBloc>().add(const AuthEvent.forcedLogoutRequested());
      }
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

        BlocProvider<NotificationBloc>(
          create: (_) => Get.find<NotificationBloc>()..add(const NotificationEvent.load()),
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

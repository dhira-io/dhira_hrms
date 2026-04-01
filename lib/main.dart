import 'package:dhira_hrms/providers/attendance_provider.dart';
import 'package:dhira_hrms/providers/auth_provider.dart';
import 'package:dhira_hrms/providers/bottom_nav_provider.dart';
import 'package:dhira_hrms/providers/change_password_provider.dart';
import 'package:dhira_hrms/providers/forgot_password_provider.dart';
import 'package:dhira_hrms/providers/leave_provider.dart';
import 'package:dhira_hrms/providers/login_provider.dart';
import 'package:dhira_hrms/providers/microsoft_sso_provider.dart';
import 'package:dhira_hrms/providers/org_chart_provider.dart';
import 'package:dhira_hrms/providers/otp_provider.dart';
import 'package:dhira_hrms/providers/popup_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_menu_provider.dart';
import 'package:dhira_hrms/providers/profile_provider.dart';
import 'package:dhira_hrms/providers/timesheet_provider.dart';
import 'package:dhira_hrms/screens/login_screen.dart';
import 'package:dhira_hrms/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();
  final authService = AuthService(navigatorKey: navigatorKey);

  runApp(MyApp(
    authService: authService,
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key,  required this.authService, required this.navigatorKey });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavProvider()),
          ChangeNotifierProvider(create: (_) => OtpProvider()),
          ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
          ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
          ChangeNotifierProvider(create: (_) => TimesheetProvider()),
          ChangeNotifierProvider(create: (_) => LeaveProvider()),
          ChangeNotifierProvider(create: (_) => PopupMenuProvider()),
          ChangeNotifierProvider(create: (_) => ProfileMenuProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => OrgChartProvider()),
          ChangeNotifierProvider(create: (_) => MicrosoftSSOProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'DHIRA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Poppins',
              primaryColor: const Color(0xff1100CC),
              cardColor: Colors.white,
              scaffoldBackgroundColor: const Color(0xffffffff),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white, elevation: 0.5)),
          home: LoginScreen(),
        ),
      ),
    );
  }
}

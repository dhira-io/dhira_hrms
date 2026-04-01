import 'package:dhira_hrms/providers/microsoft_sso_provider.dart';
import 'package:dhira_hrms/screens/forgot_password_screen.dart';
import 'package:dhira_hrms/screens/main_screen.dart';
import 'package:dhira_hrms/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/alert_dialogbox.dart'; // your dialog helper
import '../providers/login_provider.dart';
import '../widgets/login_form.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  void _onCreateAccount(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => RegisterScreen()),
    // );
  }

  void _onForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
    );
  }

  Future<void> _onSubmit(
      BuildContext context,
      String email,
      String password,
      ) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    bool success = await provider.signIn(email, password);
    if (success) {
      // Navigate to home screen or dashboard
      provider.fetchEmpbyUser(email).then((value) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen()));
      });
    }
    // If failed, error message is already in provider → UI shows it
    else {
      String msg = provider.errorMessage ?? 'Login failed';
      ShowAlertdialogue(context, msg);
      print("login =$msg");
    }
  }

  Future<void> _onMicrosoftLogin(BuildContext context) async {
/*    final authProv = context.read<AuthProvider>();

    await authProv.mslogin();
    if (!authProv.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed")),
      );
    }*/
    Provider.of<MicrosoftSSOProvider>(context, listen: false).init(context);

    const frappeBaseUrl = ApiService.baseUrl;
    const callback = "com.dhira.hrms://auth/callback";

    final loginUrl =
        "$frappeBaseUrl${ApiService.msloginEndpoint}?redirect_to=$callback";

    await launchUrl(
      Uri.parse(loginUrl),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);

    if (authProv.isLoggedIn) {
      // If already logged in, go to home screen
      return MainScreen();
    }
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: LoginForm(
              onCreateAccountTap: () => _onCreateAccount(context),
              onForgotPasswordTap: () => _onForgotPassword(context),
              onSubmit: (email, password) => _onSubmit(context, email, password),
              onMicrosoftTap: () => _onMicrosoftLogin(context),
            ),
          ),
        ),
      ),
    );
  }
}

// lib/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/forgot_password_provider.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final provider =
      Provider.of<ForgotPasswordProvider>(context, listen: false);
      provider.forgotPasswordEmail(_emailController.text.trim());
    }
  }

  void _showResultDialog(ForgotPasswordProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            provider.state == ForgotPasswordState.success
                ? 'Success'
                : 'Error',
            style: TextStyle(
              color: provider.state == ForgotPasswordState.success
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          content: Text(provider.message ?? 'Something went wrong'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                provider.resetState();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
               },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Consumer<ForgotPasswordProvider>(
        builder: (context, provider, child) {
          // When state changes to success/error, show dialog
          if (provider.state == ForgotPasswordState.success ||
              provider.state == ForgotPasswordState.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showResultDialog(provider);
            });
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter your registered email address to receive reset instructions.',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  provider.state == ForgotPasswordState.loading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text('Send Reset Link'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

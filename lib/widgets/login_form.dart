import 'package:dhira_hrms/providers/login_provider.dart';
import 'package:dhira_hrms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginForm extends StatefulWidget {
  final VoidCallback onCreateAccountTap;
  final VoidCallback onForgotPasswordTap;
  final Function(String, String) onSubmit;
  final VoidCallback onMicrosoftTap;

  const LoginForm({
    Key? key,
    required this.onCreateAccountTap,
    required this.onForgotPasswordTap,
    required this.onSubmit,
    required this.onMicrosoftTap,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(emailController.text.trim(), passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/logo.png', height: 37),
        const SizedBox(height: 10),
        Divider(color: AppColors.bordergrey,),
        const SizedBox(height: 20),

        const Text(
          'Sign in',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins'
          ),
        ),
        /*const SizedBox(height: 8),
        Row(
          children: [
            const Text('New here?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: widget.onCreateAccountTap,
              child: const Text(
                'Create an account',
                style: TextStyle(color: AppColors.primaryBlue,fontSize: 16,fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),*/
        const SizedBox(height: 56),

        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email Address"),
              const SizedBox(height: 8),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'email adress',
                  floatingLabelBehavior: FloatingLabelBehavior.never,  // ← prevent floating
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
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

              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: !provider.isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '••••••••',
                  floatingLabelBehavior: FloatingLabelBehavior.never,  // ← prevent floating
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  suffixIcon: IconButton(
                    icon: Icon(
                      provider.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: provider.togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 4) {
                    return 'Password must be at least 4 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: widget.onForgotPasswordTap,
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: AppColors.primaryBlue,fontSize: 14,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),

        if (provider.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: provider.isLoading ? null : _submit,
            child: provider.isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            )
                : const Text(
              'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Divider(color: AppColors.bordergrey,),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text("OR",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          ),
        ),

        GestureDetector(
          onTap: widget.onMicrosoftTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login with ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              const SizedBox(width: 4),
              Image.asset('assets/microsoft360.png',scale: 2,),
              const SizedBox(width: 4),
              const Text('Office 365',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
            ],
          ),
        ),
      ],
    );
  }
}

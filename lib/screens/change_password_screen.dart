import 'package:dhira_hrms/providers/change_password_provider.dart';
import 'package:dhira_hrms/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _navigateToLoginPage() {
    // Clear the current screen and push the new one, preventing the user from navigating back.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ChangePasswordProvider>(context, listen: false);
      provider.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        onSuccess: _navigateToLoginPage, // <-- PASS THE CALLBACK HERE
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Consumer<ChangePasswordProvider>(
        builder: (context, provider, child) {
          // Show alert dialog on success or error state change
          if (provider.state == ChangePasswordState.success || provider.state == ChangePasswordState.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showResultDialog(context, provider);
            });
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Current Password Field
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    labelText: 'Current Password',
                    validator: (value) => value!.isEmpty ? 'Please enter your current password.' : null,
                  ),
                  const SizedBox(height: 20),

                  // New Password Field
                  _buildPasswordField(
                    controller: _newPasswordController,
                    labelText: 'New Password',
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter a new password.';
                      if (value.length < 4) return 'Password must be at least 4 characters.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm New Password Field
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm New Password',
                    validator: (value) {
                      if (value!.isEmpty) return 'Please confirm your new password.';
                      if (value != _newPasswordController.text) return 'Passwords do not match.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // Submit Button
                  ElevatedButton(
                    onPressed: provider.state == ChangePasswordState.loading ? null : () => _submit(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.blue.withOpacity(0.5),
                    ),
                    child: provider.state == ChangePasswordState.loading
                        ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                        : const Text('Change Password', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
      ),
      validator: validator,
    );
  }

  void _showResultDialog(BuildContext context, ChangePasswordProvider provider) {
      // Store the success status before popping and resetting the state
      final bool wasSuccessful = provider.state == ChangePasswordState.success;

      showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext dialogContext) {
        return AlertDialog(
         title: Text(
          wasSuccessful ? 'Success! 🎉' : 'Error ⚠️',
          style: TextStyle(color: wasSuccessful ? Colors.green : Colors.red),
         ),
         content: Text(provider.message ?? 'An issue occurred. Please try again.'),
         actions: <Widget>[
          TextButton(
           child: const Text('OK'),
           onPressed: () {
            Navigator.of(dialogContext).pop();

            // --- START MODIFICATION ---

            // Execute the navigation on success
            if (wasSuccessful) {
             // Clear fields before navigation (optional but clean)
             _currentPasswordController.clear();
             _newPasswordController.clear();
             _confirmPasswordController.clear();

             // Execute the stored navigation function
             _navigateToLoginPage();
            }

            // Reset the provider state AFTER handling navigation, 
            // so the consumer doesn't rebuild and try to show the dialog again.
            provider.resetState();

            // --- END MODIFICATION ---
           },
          ),
         ],
        );
       },
      );
     }}
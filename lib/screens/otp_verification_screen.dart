import 'package:dhira_hrms/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/otp_provider.dart';
import 'package:pinput/pinput.dart';

import 'login_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  void _verifyOtp(BuildContext context) async {
    final provider = Provider.of<OtpProvider>(context, listen: false);
    bool success = await provider.verifyOtp();

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified successfully')),
      );
      // provider.fetchEmpbyUser(email).then((value) async {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (_) => MainScreen()));
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpProvider(),
      child: Consumer<OtpProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and Title
                  Column(
                    children: [
                      Image.asset('assets/logo.png', height: 40),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Divider(color: AppColors.bordergrey,),
                  const SizedBox(height: 40),

                  const Text(
                    'Authenticator code',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the code from your Microsoft Authenticator app or text message.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 30),

                  // OTP Input
                  Center(
                    child: Pinput(
                      length: 6,
                      onChanged: (value) => provider.setOtp(value),
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Verify button
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
                      onPressed: provider.isLoading
                          ? null
                          : () => _verifyOtp(context),
                      child: provider.isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                          : const Text(
                        'Verify & Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Divider(),
                  const SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (route) => false,
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: 'Login with a different email? ',
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

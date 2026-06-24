import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/welcome_illustration_widget.dart';
import '../widgets/welcome_bottom_panel_widget.dart';

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

/// Welcome Screen — entry screen shown on first launch.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // ✅ Dark mode: uses _darkWelcomeScaffoldBg (#0D1117) instead of white
      backgroundColor: AppColors.of(context).welcomeScaffoldBg,
      body: SafeArea(
        child: Stack(
          children: [
            /// Gradient Wave Background with Illustration inside
            /// ✅ Dark mode: welcomeTopBg switches to deep navy (#0D2137)
            Positioned(
              top: 0.h,
              left: 0.w,
              right: 0.w,
              height: screenHeight * 0.45,
              child: const SafeArea(
                bottom: false,
                child: WelcomeIllustrationWidget(),
              ),
            ),
        
            /// Bottom Content Panel
            Positioned(
              top: screenHeight * 0.45,
              left: 0.w,
              right: 0.w,
              bottom: 0.h,
              child: const WelcomeBottomPanelWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

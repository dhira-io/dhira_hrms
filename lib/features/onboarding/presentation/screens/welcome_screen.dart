import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/welcome_illustration_widget.dart';
import '../widgets/welcome_bottom_panel_widget.dart';
import '../widgets/welcome_wavy_background_widget.dart';

/// Welcome Screen — entry screen shown on first launch.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Analytics / tracking
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // ✅ Dark mode: uses _darkWelcomeScaffoldBg (#0D1117) instead of white
      backgroundColor: colors.welcomeScaffoldBg,
      body: Stack(
        children: [

          /// Glow Shadow behind the wavy gradient area
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.54,
            child: const CustomPaint(
              painter: WelcomeWavyShadowPainter(
                reverse: true,
                flip: true,
              ),
            ),
          ),

          /// Gradient Wave Background with Illustration inside
          /// ✅ Dark mode: welcomeTopBg switches to deep navy (#0D2137)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.54,
            child: ClipPath(
              clipper: const WelcomeWavyClipper(
                reverse: true,
                flip: true,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.welcomeTopBg,
                ),
                child: const WelcomeIllustrationWidget(),
              ),
            ),
          ),

          /// Bottom Content Panel
          Positioned(
            top: screenHeight * 0.54,
            left: 0,
            right: 0,
            bottom: 0,
            child: const WelcomeBottomPanelWidget(),
          ),
        ],
      ),
    );
  }
}
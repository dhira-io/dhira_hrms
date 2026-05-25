import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Custom clipper that cuts a wavy shape from the top section of WelcomeScreen.
class WelcomeWavyClipper extends CustomClipper<Path> {
  const WelcomeWavyClipper({
    this.flip = true,
    this.reverse = true,
  });

  final bool flip;
  final bool reverse;

  @override
  Path getClip(Size size) {
    final path = Path();

    if (reverse) {
      /// Bottom Wave
      path.lineTo(0.0, size.height - 5);

      path.quadraticBezierTo(
        size.width * 0.20,
        size.height + 25,
        size.width * 0.45,
        size.height - 5,
      );

      path.quadraticBezierTo(
        size.width * 0.75,
        size.height - 120,
        size.width,
        size.height - 15,
      );

      path.lineTo(size.width, 0.0);
      path.close();
    } else {
      /// Top Wave
      path.moveTo(0, 60);

      path.quadraticBezierTo(
        size.width * 0.20,
        20,
        size.width * 0.45,
        60,
      );

      path.quadraticBezierTo(
        size.width * 0.75,
        120,
        size.width,
        70,
      );

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      path.close();
    }

    /// Horizontal Flip
    if (flip) {
      final matrix = Matrix4.translationValues(size.width, 0.0, 0.0)
        ..multiply(Matrix4.diagonal3Values(-1.0, 1.0, 1.0));

      return path.transform(matrix.storage);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant WelcomeWavyClipper oldClipper) {
    return oldClipper.flip != flip || oldClipper.reverse != reverse;
  }
}

/// Custom painter that draws layered drop shadows along the wavy edge.
class WelcomeWavyShadowPainter extends CustomPainter {
  const WelcomeWavyShadowPainter({
    this.flip = true,
    this.reverse = true,
  });

  final bool flip;
  final bool reverse;

  @override
  void paint(Canvas canvas, Size size) {
    final path = WelcomeWavyClipper(
      flip: flip,
      reverse: reverse,
    ).getClip(size);

    final shadows = [
      const BoxShadow(
        color: AppColors.welcomeShadow1,
        offset: Offset(0, 3),
        blurRadius: 8,
      ),
      const BoxShadow(
        color: AppColors.welcomeShadow2,
        offset: Offset(0, 14),
        blurRadius: 14,
      ),
      const BoxShadow(
        color: AppColors.welcomeShadow3,
        offset: Offset(0, 31),
        blurRadius: 19,
      ),
      const BoxShadow(
        color: AppColors.welcomeShadow4,
        offset: Offset(0, 55),
        blurRadius: 22,
      ),
    ];

    for (final shadow in shadows) {
      final paint = Paint()
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          shadow.blurRadius * 0.6,
        );

      canvas.save();
      canvas.translate(shadow.offset.dx, shadow.offset.dy);
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant WelcomeWavyShadowPainter oldDelegate) {
    return oldDelegate.flip != flip || oldDelegate.reverse != reverse;
  }
}

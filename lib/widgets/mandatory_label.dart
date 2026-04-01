import 'package:flutter/material.dart';

class MandatoryLabel extends StatelessWidget {
  final String labeltext;
  final Color? textcolor;

  const MandatoryLabel({super.key, required this.labeltext, this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            labeltext,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const Text(
            "*",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
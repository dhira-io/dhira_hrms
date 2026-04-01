import 'package:dhira_hrms/utils/colors.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? assetImagePath;
  final Color? bgColor;
  final void Function()? onTap; // Added onTap callback

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.assetImagePath,
    required this.bgColor,
    this.onTap, // Optional onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Keeps column compact
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      assetImagePath!,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

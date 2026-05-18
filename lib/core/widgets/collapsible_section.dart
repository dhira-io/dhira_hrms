import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

class CollapsibleSection extends StatefulWidget {
  final Widget title;
  final Widget? trailing;
  final Widget child;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const CollapsibleSection({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
    this.initiallyExpanded = false,
    this.padding = const EdgeInsets.symmetric(horizontal: AppConstants.p20),
    this.margin = const EdgeInsets.symmetric(horizontal: AppConstants.p20),
  });

  @override
  State<CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          margin: widget.margin,
          child: InkWell(
            onTap: _toggleExpansion,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p12),
              child: Row(
                children: [
                  Expanded(child: widget.title),
                  if (widget.trailing != null) widget.trailing!,
                  if (widget.trailing != null) SizedBox(width: AppConstants.p8),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isExpanded ? widget.child : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

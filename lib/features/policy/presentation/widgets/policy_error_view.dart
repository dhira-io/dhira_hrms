import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';

class PolicyErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const PolicyErrorView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GenericErrorWidget(
        onRetry: onRetry,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/widgets/common_pdf_viewer.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class LeavePolicyPdfBottomSheet extends StatelessWidget {
  final String fileUrl;

  const LeavePolicyPdfBottomSheet({super.key, required this.fileUrl});

  static Future<void> show(BuildContext context, String fileUrl) {
    return CommonPdfViewer.show(
      context: context,
      title: AppLocalizations.of(context)!.leavePolicy,
      fileUrl: fileUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonPdfViewer(
      title: AppLocalizations.of(context)!.leavePolicy,
      fileUrl: fileUrl,
    );
  }
}

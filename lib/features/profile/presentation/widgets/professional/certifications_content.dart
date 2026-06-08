import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'common_form_dialog.dart';

class CertificationsContent extends StatelessWidget {
  final List<ResumeCertificationEntity> certifications;

  const CertificationsContent({super.key, required this.certifications});

  @override
  Widget build(BuildContext context) {
    if (certifications.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(AppLocalizations.of(context)!.noCertificationsAddedYet),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: certifications.length,
      separatorBuilder: (_, __) => Divider(height: 24.h),
      itemBuilder: (context, index) {
        final cert = certifications[index];
        return _CertificationItem(
          cert: cert,
          onEdit: () => _showEditCertificationDialog(context, cert),
        );
      },
    );
  }

  void _showEditCertificationDialog(
    BuildContext context,
    ResumeCertificationEntity cert,
  ) {
    final nameC = TextEditingController(text: cert.certificationName);
    final issuerC = TextEditingController(text: cert.issuingInstitute);

    int currentYear = DateTime.now().year;
    final years = List.generate(
      currentYear - 1949,
      (index) => (currentYear - index).toString(),
    );
    String yearSelected = years.contains(cert.yearObtained)
        ? cert.yearObtained
        : currentYear.toString();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: AppLocalizations.of(context)!.editCertification,
              fields: [
                TextField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.certificationName,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: issuerC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.issuerOrganization,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: yearSelected,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yearOfAcquisition,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => yearSelected = val!),
                ),
              ],
              onSave: () {
                if (nameC.text.isNotEmpty) {
                  final data = {
                    "certification_name": nameC.text,
                    "issuing_institute": issuerC.text,
                    "year_obtained": yearSelected,
                    "certification_url": cert.certificationUrl,
                  };
                  context.read<ProfileBloc>().add(
                    ProfileEvent.resumeRowUpsertRequested(
                      section: "certifications",
                      rowDataJson: jsonEncode(data),
                      rowName: cert.name,
                    ),
                  );
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }
}

class _CertificationItem extends StatelessWidget {
  final ResumeCertificationEntity cert;
  final VoidCallback onEdit;

  const _CertificationItem({required this.cert, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cert.certificationName,
                style: AppTextStyle.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "${cert.issuingInstitute} • ${cert.yearObtained}",
                style: AppTextStyle.bodyMedium.copyWith(
                  color: isDark ? colors.slate400 : colors.slate500,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 20.sp),
              onPressed: onEdit,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              color: isDark ? colors.slate400 : colors.slate500,
            ),
            SizedBox(width: 12.w),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20.sp),
              onPressed: () {
                context.read<ProfileBloc>().add(
                  ProfileEvent.resumeRowDeleteRequested(
                    section: "certifications",
                    rowName: cert.name,
                  ),
                );
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              color: isDark ? colors.slate400 : colors.slate500,
            ),
          ],
        ),
      ],
    );
  }

  void _showEditCertificationDialog(
    BuildContext context,
    ResumeCertificationEntity cert,
  ) {
    final nameC = TextEditingController(text: cert.certificationName);
    final issuerC = TextEditingController(text: cert.issuingInstitute);

    int currentYear = DateTime.now().year;
    final years = List.generate(
      currentYear - 1949,
      (index) => (currentYear - index).toString(),
    );
    String yearSelected = years.contains(cert.yearObtained)
        ? cert.yearObtained
        : currentYear.toString();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return CommonFormDialog(
              bloc: context.read<ProfileBloc>(),
              title: AppLocalizations.of(context)!.editCertification,
              fields: [
                TextField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.certificationName,
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: issuerC,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.issuerOrganization,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  value: yearSelected,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.yearOfAcquisition,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => yearSelected = val!),
                ),
              ],
              onSave: () {
                if (nameC.text.isNotEmpty) {
                  final data = {
                    "certification_name": nameC.text,
                    "issuing_institute": issuerC.text,
                    "year_obtained": yearSelected,
                    "certification_url": cert.certificationUrl,
                  };
                  context.read<ProfileBloc>().add(
                    ProfileEvent.resumeRowUpsertRequested(
                      section: "certifications",
                      rowDataJson: jsonEncode(data),
                      rowName: cert.name,
                    ),
                  );
                  Navigator.pop(dialogContext);
                }
              },
            );
          },
        );
      },
    );
  }
}

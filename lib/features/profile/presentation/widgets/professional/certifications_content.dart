import 'package:dhira_hrms/features/profile/domain/entities/resume_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/profile/data/constants/profile_api_constants.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_event.dart';
import 'package:dhira_hrms/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import 'package:get/get.dart';
import 'dialogs/common_form_bottom_sheet.dart';
import '../../../../../core/widgets/common_alert_dialog.dart';
import '../../../../../core/widgets/common_empty_view.dart';

class CertificationsContent extends StatelessWidget {
  final List<ResumeCertificationEntity> certifications;

  const CertificationsContent({super.key, required this.certifications});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (certifications.isEmpty) {
      return CommonEmptyView(
        message: l10n.noCertificationsAddedYet,
        icon: Icons.card_membership_outlined,
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
    final l10n = AppLocalizations.of(context)!;
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
    final formKey = GlobalKey<FormState>();

    CommonFormBottomSheet.show(
      context: context,
      formKey: formKey,
      bloc: context.read<ProfileBloc>(),
      title: l10n.editCertification,
      fields: [
        StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: l10n.certificationName,
                  ),
                  validator: (val) => val == null || val.trim().isEmpty
                      ? l10n.requiredField
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: issuerC,
                  decoration: InputDecoration(
                    labelText: l10n.issuerOrganization,
                  ),
                ),
                SizedBox(height: 12.h),
                DropdownButtonFormField<String>(
                  initialValue: yearSelected,
                  decoration: InputDecoration(
                    labelText: l10n.yearOfAcquisition,
                  ),
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => yearSelected = val!),
                ),
              ],
            );
          },
        ),
      ],
      onSave: () {
        if (formKey.currentState!.validate()) {
          final data = {
            ProfileApiConstants.keyCertificationName: nameC.text,
            ProfileApiConstants.keyIssuingInstitute: issuerC.text,
            ProfileApiConstants.keyYearObtained: yearSelected,
            ProfileApiConstants.keyCertificationUrl: cert.certificationUrl,
          };
          context.read<ProfileBloc>().add(
            ProfileEvent.resumeRowUpsertRequested(
              section: ProfileApiConstants.sectionCertifications,
              rowDataJson: jsonEncode(data),
              rowName: cert.name,
            ),
          );
        }
      },
    );
  }
}

class _CertificationItem extends StatefulWidget {
  final ResumeCertificationEntity cert;
  final VoidCallback onEdit;

  const _CertificationItem({required this.cert, required this.onEdit});

  @override
  State<_CertificationItem> createState() => _CertificationItemState();
}

class _CertificationItemState extends State<_CertificationItem> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = AppColors.of(context);
    final cert = widget.cert;
    final locale = AppLocalizations.of(context)!;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (_isDeleting) {
          state.maybeWhen(
            uploading: (_, __) {},
            orElse: () {
              if (mounted) setState(() => _isDeleting = false);
            },
          );
        }
      },
      child: Row(
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
                icon: Icon(Icons.edit_outlined, size: 20.h),
                onPressed: _isDeleting ? null : widget.onEdit,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                color: isDark ? colors.slate400 : colors.slate500,
              ),
              SizedBox(width: 12.w),
              if (_isDeleting)
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.of(context).error,
                  ),
                )
              else
                IconButton(
                  icon: Icon(Icons.delete_outline, size: 20.h),
                  onPressed: () {
                    CommonAlertDialog.show(
                      context: context,
                      title: locale.delete,
                      content: locale.deleteCertificationConfirmation,
                      confirmText: locale.delete,
                      cancelText: locale.cancel,
                      confirmButtonColor: AppColors.of(context).error,
                      onConfirm: () {
                        setState(() => _isDeleting = true);
                        context.read<ProfileBloc>().add(
                          ProfileEvent.resumeRowDeleteRequested(
                            section: ProfileApiConstants.sectionCertifications,
                            rowName: cert.name,
                          ),
                        );
                      },
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: Colors.red,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

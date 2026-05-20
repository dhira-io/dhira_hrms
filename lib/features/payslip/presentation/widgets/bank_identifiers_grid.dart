import 'package:dhira_hrms/features/payslip/domain/entities/payslip_entities.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../../core/widgets/common_app_bar.dart';

class BankIdentifiersGrid extends StatelessWidget {
  final PayslipDetailEntity detail;
  final AppLocalizations l10n;

  const BankIdentifiersGrid({required this.detail, required this.l10n});

  String _maskedAccount(String accountNo) {
    if (accountNo.isEmpty) return AppConstants.placeholderText;
    if (accountNo.length <= 4) return accountNo;
    return '••••${accountNo.substring(accountNo.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _BankItem(label: l10n.bankName, value: detail.bankName),
      _BankItem(label: l10n.accountNumber, value: _maskedAccount(detail.bankAccountNo)),
      _BankItem(label: l10n.panNumber, value: detail.panNumber),
      _BankItem(label: l10n.pfNumber, value: detail.pfNumber),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppConstants.p10,
      crossAxisSpacing: AppConstants.p10,
      childAspectRatio: 2.2,
      children: items.map((item) => _BankCell(item: item)).toList(),
    );
  }
}

class _BankItem {
  final String label;
  final String value;
  const _BankItem({required this.label, required this.value});
}

class _BankCell extends StatelessWidget {
  final _BankItem item;
  const _BankCell({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.label.toUpperCase(),
            style: AppTextStyle.labelSmall.copyWith(
              color: colors.primary,
              fontSize: 9,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.p4),
          Text(
            item.value.isNotEmpty ? item.value : AppConstants.placeholderText,
            style: AppTextStyle.bodyMedium.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

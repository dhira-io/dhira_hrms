import 'package:dhira_hrms/features/performance/presentation/bottom_sheets/kpi_edit_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/kra_entity.dart';
import '../../domain/entities/kpi_entity.dart';
import '../bottom_sheets/kra_edit_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/performance_bloc.dart';
import '../dialogs/kpi_delete_dialog.dart';
import '../dialogs/kra_delete_dialog.dart';

class PerformanceReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final bool isLoading;

  const PerformanceReadOnlyField({
    super.key,
    required this.label,
    required this.value,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.p8),
          child: Text(
            label,
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        if (isLoading)
          ShimmerLoading(
            height: 48,
            width: double.infinity,
            borderRadius: AppConstants.r12,
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p16,
              vertical: AppConstants.p14,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest.withValues(
                alpha: AppConstants.opacityMedium,
              ),
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(
                  alpha: AppConstants.opacityMedium,
                ),
              ),
            ),
            child: Text(
              value,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant.withValues(
                  alpha: AppConstants.opacityMuted,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class PerformanceEmptyStateCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isLoading;
  final bool isEditable;

  const PerformanceEmptyStateCard({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.isLoading = false,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerLoading(
        height: 200,
        width: double.infinity,
        borderRadius: AppConstants.r16,
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppConstants.opacityExtraLow,
            ),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.h3Bold),
          const SizedBox(height: AppConstants.p24),
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: AppConstants.p40,
                    color: AppColors.onSurfaceVariant.withValues(
                      alpha: AppConstants.p40 / 100,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                Text(
                  message,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                if (actionLabel != null && isEditable) ...[
                  const SizedBox(height: AppConstants.p16),
                  OutlinedButton.icon(
                    onPressed: onAction,
                    icon: const Icon(Icons.add, size: AppConstants.iconSmall),
                    label: Text(actionLabel!),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p24,
                        vertical: AppConstants.p12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEditable;

  const PerformanceActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool effectivelyEnabled = isEditable && !isLoading;
    final double opacity = isEditable ? 1.0 : 0.6;

    return Padding(
      padding: const EdgeInsets.all(AppConstants.p16),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: isLoading || !isEditable
                ? null
                : const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryContainer],
                  ),
            color: isLoading || !isEditable ? AppColors.outlineVariant : null,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            boxShadow: isLoading || !isEditable
                ? null
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: AppConstants.opacitySlight,
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: effectivelyEnabled ? onPressed : null,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              splashColor: AppColors.white.withValues(
                alpha: AppConstants.opacitySlight,
              ),
              highlightColor: AppColors.white.withValues(
                alpha: AppConstants.opacityLow,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          height: AppConstants.p20,
                          width: AppConstants.p20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onPrimary,
                          ),
                        )
                      : Text(
                          label,
                          style: AppTextStyle.button.copyWith(
                            color: AppColors.onPrimary,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PerformancePlaceholderContent extends StatelessWidget {
  final String title;

  const PerformancePlaceholderContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p24),
        child: Text(title, style: AppTextStyle.bodyLarge),
      ),
    );
  }
}

class PerformanceKraSection extends StatelessWidget {
  final Map<String, double> kraWeightages;
  final double totalWeightage;
  final double progress;
  final String title;
  final VoidCallback? onAdd;
  final bool isLoading;
  final bool isEditable;

  const PerformanceKraSection({
    super.key,
    required this.kraWeightages,
    required this.totalWeightage,
    required this.progress,
    required this.title,
    this.onAdd,
    this.isLoading = false,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerLoading(
        height: 250,
        width: double.infinity,
        borderRadius: AppConstants.r16,
      );
    }

    final l10n = AppLocalizations.of(context)!;
    final List<MapEntry<String, double>> derivedKras = kraWeightages.entries
        .toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(
            alpha: AppConstants.opacitySlight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppConstants.opacityExtraLow,
            ),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p10,
              vertical: AppConstants.p12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
                ),
                if (onAdd != null && isEditable)
                  Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: onAdd,
                      splashColor: AppColors.primary.withValues(alpha: 0.1),
                      highlightColor: AppColors.primary.withValues(alpha: 0.05),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(
                            alpha: AppConstants.opacitySlight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(
                                alpha: AppConstants.opacityExtraLow,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          size: AppConstants.iconXMedium,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p10,
              vertical: AppConstants.p10,
            ),
            color: AppColors.surfaceContainerLow,
            child: Row(
              children: [
                SizedBox(
                  width: AppConstants.p32,
                  child: Text(l10n.slNo, style: AppTextStyle.labelSmall),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p12,
                    ),
                    child: Text(l10n.kra, style: AppTextStyle.labelSmall),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    l10n.weightage,
                    style: AppTextStyle.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (isEditable)
                  SizedBox(
                    width: 100,
                    child: Text(
                      l10n.actions,
                      style: AppTextStyle.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),

          // List Items
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: derivedKras.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: AppColors.surfaceContainer.withValues(
                alpha: AppConstants.opacityLow,
              ),
            ),
            itemBuilder: (context, index) {
              final kraEntry = derivedKras[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.p10,
                  vertical: isEditable ? 0 : AppConstants.p12,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: AppConstants.p32,
                      child: Text(
                        '${index + 1}',
                        style: AppTextStyle.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.p12,
                        ),
                        child: Text(
                          kraEntry.key,
                          style: AppTextStyle.bodySmall,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${kraEntry.value.toInt()}',
                        style: AppTextStyle.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (isEditable)
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                final kraEntity = KraEntity(
                                  name: kraEntry.key,
                                  weightage: kraEntry.value,
                                );
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: AppColors.transparent,
                                  builder: (innerContext) => BlocProvider.value(
                                    value: context.read<PerformanceBloc>(),
                                    child: KraEditBottomSheet(kra: kraEntity),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: AppConstants.iconSmall,
                                color: AppColors.primary,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 20,
                            ),
                            const SizedBox(width: AppConstants.p4),
                            IconButton(
                              onPressed: () {
                                final kraEntity = KraEntity(
                                  name: kraEntry.key,
                                  weightage: kraEntry.value,
                                );
                                showDialog(
                                  context: context,
                                  builder: (innerContext) => BlocProvider.value(
                                    value: context.read<PerformanceBloc>(),
                                    child: KraDeleteDialog(kra: kraEntity),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                size: AppConstants.iconSmall,
                                color: AppColors.error,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          // Footer
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.p20,
              AppConstants.p12,
              AppConstants.p20,
              AppConstants.p20,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.totalWeightage,
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      l10n.weightageValue(totalWeightage.toInt().toString()),
                      style: AppTextStyle.labelSmall.copyWith(
                        color: totalWeightage > 100
                            ? AppColors.error
                            : AppColors.pmsSuccess,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.p12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: AppConstants.p6,
                    backgroundColor: AppColors.surfaceContainer,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      totalWeightage > 100
                          ? AppColors.error
                          : AppColors.pmsSuccess,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceKpiAccordion extends StatefulWidget {
  final Map<String, List<KpiEntity>> kraGroups;
  final String title;
  final String subtitle;
  final bool isLoading;
  final bool isEditable;
  final Function(String kraName)? onAddKpi;

  const PerformanceKpiAccordion({
    super.key,
    required this.kraGroups,
    required this.title,
    required this.subtitle,
    this.isLoading = false,
    this.isEditable = true,
    this.onAddKpi,
  });

  @override
  State<PerformanceKpiAccordion> createState() =>
      _PerformanceKpiAccordionState();
}

class _PerformanceKpiAccordionState extends State<PerformanceKpiAccordion> {
  int? _expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return ShimmerLoading(
        height: 300,
        width: double.infinity,
        borderRadius: AppConstants.r16,
      );
    }

    final List<String> uniqueKraNames = widget.kraGroups.keys.toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(
            alpha: AppConstants.opacitySlight,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppConstants.opacityExtraLow,
            ),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p10,
              vertical: AppConstants.p20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: AppTextStyle.h3Bold),
                const SizedBox(height: AppConstants.p4),
                Text(
                  widget.subtitle,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Items
          Column(
            children: List.generate(uniqueKraNames.length, (index) {
              final kraName = uniqueKraNames[index];
              final kraKpis = widget.kraGroups[kraName]!;
              final isExpanded = _expandedIndex == index;

              return Column(
                children: [
                  if (index > 0) const Divider(height: 1),
                  PerformanceKraItem(
                    index: index,
                    kraName: kraName,
                    kraKpis: kraKpis,
                    isExpanded: isExpanded,
                    isEditable: widget.isEditable,
                    onTap: () => setState(
                      () => _expandedIndex = isExpanded ? null : index,
                    ),
                    onAddKpi: widget.onAddKpi,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PerformanceKraItem extends StatelessWidget {
  final int index;
  final String kraName;
  final List<KpiEntity> kraKpis;
  final bool isExpanded;
  final bool isEditable;
  final VoidCallback onTap;
  final Function(String)? onAddKpi;

  const PerformanceKraItem({
    super.key,
    required this.index,
    required this.kraName,
    required this.kraKpis,
    required this.isExpanded,
    required this.isEditable,
    required this.onTap,
    this.onAddKpi,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p10,
              vertical: AppConstants.p16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        isExpanded ? Icons.expand_more : Icons.chevron_right,
                        color: isExpanded
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppConstants.p12),
                      Expanded(
                        child: Text(
                          '${index + 1}. $kraName',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onAddKpi != null && isEditable)
                  Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () => onAddKpi!(kraName),
                      splashColor: AppColors.primary.withValues(
                        alpha: AppConstants.opacityLow,
                      ),
                      highlightColor: AppColors.primary.withValues(
                        alpha: AppConstants.opacityVeryLow,
                      ),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(
                            alpha: AppConstants.opacitySlight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(
                                alpha: AppConstants.opacityExtraLow,
                              ),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          size: AppConstants.iconXMedium,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            color: AppColors.surfaceContainerLowest,
            padding: const EdgeInsets.only(bottom: AppConstants.p20),
            child: Column(
              children: [
                // Inner Table Header
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.surfaceContainer.withValues(
                          alpha: AppConstants.opacityMedium,
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: AppConstants.p32,
                        child: Text(
                          l10n.no,
                          style: AppTextStyle.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.p12,
                          ),
                          child: Text(
                            l10n.kpiQuestion,
                            style: AppTextStyle.labelSmall,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          l10n.weightage,
                          style: AppTextStyle.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (isEditable)
                        SizedBox(
                          width: 80,
                          child: Text(
                            l10n.action,
                            style: AppTextStyle.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),

                // Inner List
                if (kraKpis.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppConstants.p20),
                    child: Text(
                      l10n.noKpisDefined,
                      style: AppTextStyle.bodySmall,
                    ),
                  )
                else
                  ...kraKpis.asMap().entries.map((entry) {
                    final kpiIndex = entry.key;
                    final kpi = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p10,
                        vertical: AppConstants.p4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppConstants.p32,
                            child: Text(
                              '${kpiIndex + 1}',
                              style: AppTextStyle.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.p8,
                              ),
                              child: Text(
                                kpi.title,
                                style: AppTextStyle.bodySmall,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${kpi.weightage.toInt()}',
                              style: AppTextStyle.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (isEditable)
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: AppColors.transparent,
                                        builder: (innerContext) =>
                                            BlocProvider.value(
                                              value: context
                                                  .read<PerformanceBloc>(),
                                              child: KpiEditBottomSheet(
                                                kpi: kpi,
                                              ),
                                            ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: AppConstants.iconSmall,
                                      color: AppColors.primary,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashRadius: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (innerContext) =>
                                            BlocProvider.value(
                                              value: context
                                                  .read<PerformanceBloc>(),
                                              child: KpiDeleteDialog(kpi: kpi),
                                            ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: AppConstants.iconXMedium,
                                      color: AppColors.error,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    splashRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
      ],
    );
  }
}

class PerformanceSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const PerformanceSaveButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p12),
                  Text(
                    l10n.saving,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Text(
                l10n.save,
                style: AppTextStyle.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

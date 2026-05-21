import 'package:dhira_hrms/features/payslip/presentation/widgets/filter_row.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/ytd_banner.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/payslip_shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';

class PayslipListScreen extends StatefulWidget {
  const PayslipListScreen({super.key});

  @override
  State<PayslipListScreen> createState() => _PayslipListScreenState();
}

class _PayslipListScreenState extends State<PayslipListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final empId = Get.find<LocalStorageService>().getEmpId() ?? '';
      context.read<PayslipBloc>().add(
            PayslipEvent.fetchPayslips(employeeId: empId),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(
        title: l10n.payslips,
        onBack: () => context.pop(),
      ),
      body: BlocBuilder<PayslipBloc, PayslipState>(
        buildWhen: (previous, current) =>
            previous.isListLoading != current.isListLoading ||
            previous.listError != current.listError ||
            previous.payslips != current.payslips,
        builder: (context, state) {
          if (state.isListLoading) {
            return const PayslipListShimmer();
          }
          if (state.listError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded, color: AppColors.of(context).error, size: 48),
                  const SizedBox(height: AppConstants.p12),
                  Text(
                    state.listError!,
                    style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final formatter = NumberFormat.currency(symbol: '₹', decimalDigits: 0, locale: 'en_IN');

          return CustomScrollView(
            slivers: [
              // YTD Stats Banner
              SliverToBoxAdapter(
                child: YtdBanner(ytd: state.ytdTotal, formatter: formatter, l10n: l10n),
              ),

              // Filters
              const SliverToBoxAdapter(
                child: FilterRow(),
              ),

              BlocBuilder<PayslipBloc, PayslipState>(
                buildWhen: (previous, current) =>
                    previous.selectedYear != current.selectedYear ||
                    previous.selectedMonth != current.selectedMonth ||
                    previous.payslips != current.payslips,
                builder: (context, state) {
                  final filtered = state.filteredPayslips;

                  if (filtered.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          l10n.noPayslipsFound,
                          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppConstants.p16,
                      AppConstants.p8,
                      AppConstants.p16,
                      AppConstants.p24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final payslip = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppConstants.p12),
                            child: PayslipCard(payslip: payslip, formatter: formatter),
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

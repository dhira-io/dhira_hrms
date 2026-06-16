import 'package:dhira_hrms/features/payslip/presentation/widgets/filter_row.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/ytd_banner.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/payslip_shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import '../../../../core/widgets/generic_error_widget.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';

class PayslipListScreen extends StatefulWidget {
  const PayslipListScreen({super.key});

  @override
  State<PayslipListScreen> createState() => _PayslipListScreenState();
}

class _PayslipListScreenState extends State<PayslipListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<PayslipBloc>().add(const PayslipEvent.fetchPayslips());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final bloc = context.read<PayslipBloc>();
      final state = bloc.state;
      if (!state.isListLoading &&
          !state.isLoadMoreLoading &&
          !state.hasReachedMax) {
        bloc.add(PayslipEvent.fetchPayslips(start: state.payslips.length));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
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
            return GenericErrorWidget(
              onRetry: () {
                context.read<PayslipBloc>().add(
                  const PayslipEvent.fetchPayslips(),
                );
              },
              message: state.listError,
            );
          }

          final formatter = NumberFormat.currency(
            symbol: '₹',
            decimalDigits: 0,
            locale: 'en_IN',
          );

          return RefreshIndicator(
            onRefresh: () async {
              final bloc = context.read<PayslipBloc>();
              bloc.add(const PayslipEvent.fetchPayslips(start: 0));
              await bloc.stream.firstWhere((state) => !state.isListLoading);
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(child: AppHeader()),
                // YTD Stats Banner
                SliverToBoxAdapter(
                  child: YtdBanner(
                    ytd: state.ytdTotal,
                    formatter: formatter,
                    l10n: l10n,
                  ),
                ),

                // Filters
                const SliverToBoxAdapter(child: FilterRow()),

                BlocBuilder<PayslipBloc, PayslipState>(
                  buildWhen: (previous, current) =>
                      previous.selectedYear != current.selectedYear ||
                      previous.selectedMonth != current.selectedMonth ||
                      previous.payslips != current.payslips ||
                      previous.isLoadMoreLoading != current.isLoadMoreLoading,
                  builder: (context, state) {
                    final filtered = state.filteredPayslips;

                    if (filtered.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(
                            l10n.noPayslipsFound,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.of(context).textSecondary,
                            ),
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
                            if (index >= filtered.length) {
                              return const PayslipCardShimmer();
                            }
                            final payslip = filtered[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppConstants.p12,
                              ),
                              //TODO- add key as data id for PayslipCard
                              child: PayslipCard(
                                payslip: payslip,
                                formatter: formatter,
                              ),
                            );
                          },
                          childCount:
                              filtered.length +
                              (state.isLoadMoreLoading ? 2 : 0),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/policy_bloc.dart';
import '../bloc/policy_event.dart';
import '../bloc/policy_state.dart';
import '../../domain/entities/policy_entity.dart';
import 'policy_list_item_widget.dart';
import 'policy_card_item_widget.dart';
import 'package:provider/provider.dart';

class PolicyContentView extends StatefulWidget {
  const PolicyContentView({super.key});

  @override
  State<PolicyContentView> createState() => _PolicyContentViewState();
}

class _PolicyContentViewState extends State<PolicyContentView> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    context.read<PolicyBloc>().add(PolicyEvent.searchQueryChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.r16),
                topRight: Radius.circular(AppConstants.r16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(context, l10n),
                  SizedBox(height: AppConstants.p16.h),
                  _buildControlsRow(context, l10n),
                  SizedBox(height: AppConstants.p16.h),
                  Expanded(
                    child: BlocBuilder<PolicyBloc, PolicyState>(
                      builder: (context, state) {
                        if (state.filteredPolicies.isEmpty) {
                          return Center(
                            child: Text(
                              l10n.noResultsFound,
                              style: AppTextStyle.bodyMedium,
                            ),
                          );
                        }

                        if (state.isGridView) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: AppConstants.p12.w,
                                  mainAxisSpacing: AppConstants.p12.h,
                                  childAspectRatio: 0.75,
                                ),
                            itemCount: state.filteredPolicies.length,
                            itemBuilder: (context, index) {
                              return Provider<int>.value(
                                value: index,
                                child: Provider<PolicyEntity>.value(
                                  value: state.filteredPolicies[index],
                                  child: const PolicyCardItemWidget(),
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.separated(
                            itemCount: state.filteredPolicies.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: AppConstants.p10.h),
                            itemBuilder: (context, index) {
                              return Provider<int>.value(
                                value: index,
                                child: Provider<PolicyEntity>.value(
                                  value: state.filteredPolicies[index],
                                  child: const PolicyListItemWidget(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.policyHubSubtitle,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildControlsRow(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            border: Border.all(
              color: AppColors.of(
                context,
              ).outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: AppTextStyle.bodyMedium,
            decoration: InputDecoration(
              hintText: l10n.searchPolicies,
              hintStyle: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).outline,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.of(context).outline,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
            ),
          ),
        ),
        SizedBox(height: AppConstants.p16.h),
        BlocBuilder<PolicyBloc, PolicyState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(text: '${l10n.showing} '),
                      TextSpan(
                        text: '${state.filteredPolicies.length}',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.of(context).onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' ${l10n.policiesCount}'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(AppConstants.p4.w),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: state.isGridView
                            ? () {
                                FocusScope.of(context).unfocus();
                                context.read<PolicyBloc>().add(
                                  const PolicyEvent.toggleViewMode(),
                                );
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(AppConstants.p8.w),
                          decoration: BoxDecoration(
                            color: !state.isGridView
                                ? AppColors.of(context).surfaceContainerLowest
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              AppConstants.r8,
                            ),
                          ),
                          child: Icon(
                            Icons.view_list,
                            color: !state.isGridView
                                ? AppColors.of(context).primary
                                : AppColors.of(context).onSurfaceVariant,
                            size: AppConstants.iconSmall,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: !state.isGridView
                            ? () {
                                FocusScope.of(context).unfocus();
                                context.read<PolicyBloc>().add(
                                  const PolicyEvent.toggleViewMode(),
                                );
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(AppConstants.p8.w),
                          decoration: BoxDecoration(
                            color: state.isGridView
                                ? AppColors.of(context).surfaceContainerLowest
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              AppConstants.r8,
                            ),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            color: state.isGridView
                                ? AppColors.of(context).primary
                                : AppColors.of(context).onSurfaceVariant,
                            size: AppConstants.iconSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

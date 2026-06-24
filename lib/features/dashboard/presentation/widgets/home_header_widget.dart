import 'package:dhira_hrms/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:dhira_hrms/features/dashboard/data/models/search_menu_item.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/search_cubit.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        _searchCubit.initItems([
          SearchMenuItem(title: l10n.home, icon: Icons.dashboard_outlined, bottomNavIndex: 0),
          SearchMenuItem(title: l10n.timesheet, icon: Icons.access_time, route: AppRouter.timesheetPath),
          SearchMenuItem(title: l10n.applyLeave, subtitle: l10n.applyLeaveSubtitle, icon: Icons.calendar_today_outlined, route: AppRouter.applyLeavePath),
          SearchMenuItem(title: l10n.compensatoryLeave, subtitle: l10n.requestCompensatoryLeave, icon: Icons.card_giftcard_outlined, route: AppRouter.compensatoryLeavePath),
          SearchMenuItem(title: l10n.attendanceRegularization, icon: Icons.person_add_alt_1_outlined, route: AppRouter.attendanceRegularizationPath),
          SearchMenuItem(title: l10n.attendance, icon: Icons.assignment_turned_in_outlined, bottomNavIndex: 1),
          SearchMenuItem(title: l10n.calendar, icon: Icons.calendar_month_outlined, bottomNavIndex: 1),
          SearchMenuItem(title: l10n.organizationHierarchy, icon: Icons.account_tree_outlined, route: AppRouter.comingSoonPath),
          SearchMenuItem(title: l10n.projectBasedServiceHierarchy, icon: Icons.bar_chart_outlined, route: AppRouter.comingSoonPath),
          SearchMenuItem(title: l10n.myActions, icon: Icons.check_box_outlined, bottomNavIndex: 2),
          SearchMenuItem(title: l10n.myProfile, icon: Icons.person_outline, route: AppRouter.profilePath),
        ]);
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    _hideOverlay();
    _searchCubit.close();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    
    final parentContext = context;
    
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: _layerLink.leaderSize?.width ?? MediaQuery.of(context).size.width - 40.w,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, ( _layerLink.leaderSize?.height ?? 30.h ) + 8.h),
            child: BlocProvider.value(
              value: _searchCubit,
              child: _SearchOverlayContent(
                onItemSelected: (item) {
                  _focusNode.unfocus();
                  _searchController.clear();
                  _searchCubit.updateQuery('');
                  
                  if (item.bottomNavIndex != null) {
                    parentContext.read<BottomNavCubit>().changeIndex(item.bottomNavIndex!);
                  } else if (item.route != null) {
                    parentContext.push(item.route!);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 8.h, bottom: 50.h),
          decoration: BoxDecoration(
            color: colors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.p20.w),
                child: Builder(
                  builder: (context) {
                    final authName = context.select<AuthBloc, String?>((bloc) => bloc.state.maybeWhen(
                      authenticated: (user) => user.fullName,
                      orElse: () => null,
                    ));
                    final profileName = context.select<ProfileBloc, String?>((bloc) => bloc.state.maybeWhen(
                      loaded: (profile, resume) => profile.fullName,
                      orElse: () => null,
                    ));
                    
                    final fullName = profileName ?? authName;
                    final displayFirstName = fullName?.split(' ').first ?? AppLocalizations.of(context)!.employeeName;
                    
                    return Text(
                      "${AppLocalizations.of(context)!.welcomeName} $displayFirstName!",
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.p20.w),
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: Container(
                    height: 40.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: AppConstants.p16.w),
                        Icon(
                          Icons.search,
                          color: AppColors.searchHint,
                          size: 20.w,
                        ),
                        SizedBox(width: AppConstants.p8.w),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _focusNode,
                            onChanged: (value) {
                              _searchCubit.updateQuery(value);
                              if (_overlayEntry != null) {
                                _overlayEntry!.markNeedsBuild();
                              }
                            },
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.searchForSomething,
                              hintStyle: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.searchHint,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        SizedBox(width: AppConstants.p8.w),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchOverlayContent extends StatelessWidget {
  final ValueChanged<SearchMenuItem> onItemSelected;

  const _SearchOverlayContent({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8.r),
      color: colors.surface,
      child: Container(
        constraints: BoxConstraints(maxHeight: 300.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: colors.surface,
          border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            final items = state.filteredItems;
            
            if (items.isEmpty) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  AppLocalizations.of(context)!.noDataFound,
                  style: AppTextStyle.bodyMedium.copyWith(color: colors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              );
            }
            
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.query.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 4.h),
                    child: Text(
                      AppLocalizations.of(context)!.allPages.toUpperCase(),
                      style: AppTextStyle.bodySmall.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        ),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 4.h),
                    child: Text(
                      AppLocalizations.of(context)!.pages.toUpperCase(),
                      style: AppTextStyle.bodySmall.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        ),
                    ),
                  ),
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return InkWell(
                        onTap: () => onItemSelected(item),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  item.icon,
                                  size: 20.w,
                                  color: colors.primary,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: AppTextStyle.bodyMedium.copyWith(
                                        color: colors.onSurface,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (item.subtitle != null) ...[
                                      SizedBox(height: 2.h),
                                      Text(
                                        item.subtitle!,
                                        style: AppTextStyle.bodySmall.copyWith(
                                          color: colors.onSurfaceVariant,
                                          ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

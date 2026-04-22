import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/home_user_header.dart';
import '../widgets/home_action_sections.dart';
import '../widgets/home_overlay_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final HomeOverlayManager _overlayManager = HomeOverlayManager();

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _menuController, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeIn,
    );

    _searchController.addListener(() {
      context.read<DashboardCubit>().onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _menuController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _overlayManager.hideOverlays();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listenWhen: (prev, curr) =>
          prev.isProfileMenuOpen != curr.isProfileMenuOpen ||
              prev.isMainMenuOpen != curr.isMainMenuOpen,
          listener: (context, state) {
            if (state.isProfileMenuOpen) {
              _overlayManager.showProfilePopup(
                context: context,
                dashboardCubit: context.read<DashboardCubit>(),
                authBloc: context.read<AuthBloc>(),
              );
            } else if (state.isMainMenuOpen) {
              _overlayManager.showMainMenu(
                context: context,
                dashboardCubit: context.read<DashboardCubit>(),
                menuController: _menuController,
                slideAnimation: _slideAnimation,
                fadeAnimation: _fadeAnimation,
              );
            } else {
              if (_menuController.isCompleted) {
                _menuController.reverse().then(
                      (_) => _overlayManager.hideOverlays(),
                );
              } else {
                _overlayManager.hideOverlays();
              }
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              unauthenticated: () => context.go(AppRouter.loginPath),
              orElse: () {},
            );
          },
        ),
      ],
      child: GestureDetector(
        onTap: () => _searchFocusNode.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              const DashboardHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Blue Header Section with Search
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const HomeUserHeader(),
                          // Overlapping Search Bar
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: -25,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.textPrimary.withValues(
                                      alpha: 0.1,
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                decoration: InputDecoration(
                                  hintText: l10n.searchServices,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: AppColors.textPrimary,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _searchController.clear(),
                                  )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 45),
                      // Grid Sections
                      const HomeActionSections(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
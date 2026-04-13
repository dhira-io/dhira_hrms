import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_event.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../shared/components/action_card.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/dashboard_header.dart';
import 'package:get/get.dart';
import '../../../../core/network/dio_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  OverlayEntry? _profileOverlay;
  OverlayEntry? _menuOverlay;

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

    _fadeAnimation = CurvedAnimation(parent: _menuController, curve: Curves.easeIn);

    _searchController.addListener(() {
      context.read<DashboardCubit>().onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _menuController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _hideOverlays();
    super.dispose();
  }

  void _hideOverlays() {
    _profileOverlay?.remove();
    _profileOverlay = null;
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  void _showProfilePopup() {
    _hideOverlays();
    final dashboardCubit = context.read<DashboardCubit>();
    final authBloc = context.read<AuthBloc>();
    _profileOverlay = OverlayEntry(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: dashboardCubit),
          BlocProvider.value(value: authBloc),
        ],
        child: Builder(
          builder: (popupContext) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => popupContext.read<DashboardCubit>().closeMenus(),
                  child: Container(color: Colors.transparent),
                ),
              ),
              Positioned(
                top: kToolbarHeight + MediaQuery.of(popupContext).padding.top + 8,
                right: 16,
                child: Material(
                  color: Colors.white,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _popupItem(popupContext, 'My Profile', Icons.person, () {
                          popupContext.read<DashboardCubit>().closeMenus();
                          popupContext.push(AppRouter.profilePath);
                        }),
                        _popupItem(popupContext, 'Change Password', Icons.password, () {
                          popupContext.read<DashboardCubit>().closeMenus();
                          popupContext.push(AppRouter.changePasswordPath);
                        }),
                        const Divider(),
                        _popupItem(popupContext, 'Sign Out', Icons.logout, () {
                          popupContext.read<DashboardCubit>().closeMenus();
                          popupContext.read<AuthBloc>().add(const AuthEvent.logoutRequested());
                          popupContext.go(AppRouter.loginPath);
                        }, textColor: Colors.red),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_profileOverlay!);
  }

  void _showMainMenu() {
    _hideOverlays();
    final dashboardCubit = context.read<DashboardCubit>();
    _menuOverlay = OverlayEntry(
      builder: (_) => BlocProvider.value(
        value: dashboardCubit,
        child: Builder(
          builder: (menuContext) => Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => menuContext.read<DashboardCubit>().closeMenus(),
                  child: AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) => Container(
                      color: Colors.black.withOpacity(_fadeAnimation.value * 0.4),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: kToolbarHeight + MediaQuery.of(menuContext).padding.top,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Material(
                      elevation: 8,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _popupItem(menuContext, 'Calendar', Icons.calendar_month, () {
                              menuContext.read<DashboardCubit>().closeMenus();
                              // Navigate or switch tab
                            }),
                            _popupItem(menuContext, 'Timesheet', Icons.access_time, () {
                              menuContext.read<DashboardCubit>().closeMenus();
                              menuContext.push(AppRouter.timesheetPath);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_menuOverlay!);
    _menuController.forward();
  }

  Widget _popupItem(BuildContext context, String title, IconData icon, VoidCallback onTap, {Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: textColor ?? Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 14, color: textColor ?? Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardCubit, DashboardState>(
          listenWhen: (prev, curr) => prev.isProfileMenuOpen != curr.isProfileMenuOpen || prev.isMainMenuOpen != curr.isMainMenuOpen,
          listener: (context, state) {
            if (state.isProfileMenuOpen) {
              _showProfilePopup();
            } else if (state.isMainMenuOpen) {
              _showMainMenu();
            } else {
              if (_menuController.isCompleted) {
                _menuController.reverse().then((_) => _hideOverlays());
              } else {
                _hideOverlays();
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
                      // Blue Header Section
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final userProfile = state.maybeWhen(
                                  authenticated: (user) => user,
                                  orElse: () => null,
                                );

                                return Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: (userProfile?.userImage != null && userProfile!.userImage!.isNotEmpty)
                                          ? NetworkImage("${Get.find<DioClient>().baseUrl}${userProfile.userImage}")
                                          : const AssetImage(AppAssets.defaultProfile) as ImageProvider,
                                      radius: 30,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateTimeUtils.getGreetingMessage(prefix: ""),
                                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userProfile?.fullName ?? "User",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            "Software Engineer",
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset("assets/dashboardimg.png", height: 80),
                                  ],
                                );
                              },
                            ),
                          ),
                          // Overlapping Search Bar
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: -25,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                decoration: InputDecoration(
                                  hintText: "Search services...",
                                  prefixIcon: const Icon(Icons.search, color: Colors.black87),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear, size: 20),
                                          onPressed: () => _searchController.clear(),
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
                      BlocBuilder<DashboardCubit, DashboardState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSection("Employee Actions", state.filteredEmployeeActions),
                                const SizedBox(height: 30),
                                _buildSection("Company Information", state.filteredCompanyInfo),
                                const SizedBox(height: 30),
                              ],
                            ),
                          );
                        },
                      ),
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

  Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        if (items.isEmpty)
          const Center(child: Text("No results found"))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.1,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ActionCard(
                title: item.title,
                subtitle: item.subtitle,
                assetImagePath: item.assetImagePath,
                bgColor: item.bgColor,
                onTap: () {
                  if (item.route == AppRouter.attendancePath) {
                    context.read<BottomNavCubit>().changeIndex(1);
                  } else {
                    context.push(item.route);
                  }
                },
              );
            },
          ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import '../bloc/dashboard_cubit.dart';
import 'home_profile_popup.dart';
import 'home_main_menu.dart';

/// Manages the profile popup and main menu overlay entries for HomeScreen.
class HomeOverlayManager {
  OverlayEntry? _profileOverlay;
  OverlayEntry? _menuOverlay;

  void hideOverlays() {
    _profileOverlay?.remove();
    _profileOverlay = null;
    _menuOverlay?.remove();
    _menuOverlay = null;
  }

  void showProfilePopup({
    required BuildContext context,
    required DashboardCubit dashboardCubit,
    required AuthBloc authBloc,
  }) {
    hideOverlays();
    _profileOverlay = OverlayEntry(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: dashboardCubit),
          BlocProvider.value(value: authBloc),
        ],
        child: const HomeProfilePopup(),
      ),
    );
    Overlay.of(context).insert(_profileOverlay!);
  }

  void showMainMenu({
    required BuildContext context,
    required DashboardCubit dashboardCubit,
    required AnimationController menuController,
    required Animation<Offset> slideAnimation,
    required Animation<double> fadeAnimation,
  }) {
    hideOverlays();
    _menuOverlay = OverlayEntry(
      builder: (_) => BlocProvider.value(
        value: dashboardCubit,
        child: HomeMainMenu(
          slideAnimation: slideAnimation,
          fadeAnimation: fadeAnimation,
        ),
      ),
    );
    Overlay.of(context).insert(_menuOverlay!);
    menuController.forward();
  }
}

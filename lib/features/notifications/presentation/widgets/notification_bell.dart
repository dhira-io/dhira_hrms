import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../dashboard/presentation/bloc/bottom_nav_cubit.dart';

class NotificationBell extends StatelessWidget {
  final Color? color;
  const NotificationBell({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<BottomNavCubit>().changeIndex(BottomNavCubit.notificationsIndex);
      },
      icon: Icon(
        Icons.notifications,
        color: color ?? AppColors.onSurfaceVariant,
        size: AppConstants.iconMedium,
      ),
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      splashRadius: 24,
    );
  }
}

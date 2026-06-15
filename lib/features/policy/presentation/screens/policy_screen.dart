import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/policy/presentation/bloc/policy_bloc.dart';
import 'package:dhira_hrms/features/policy/presentation/bloc/policy_state.dart';
import 'package:dhira_hrms/features/policy/presentation/widgets/policy_content_view.dart';
import 'package:dhira_hrms/features/policy/presentation/widgets/policy_skeleton.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: CommonAppBar(title: AppLocalizations.of(context)!.policyHub),
        body: SafeArea(
          child: BlocListener<PolicyBloc, PolicyState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage,
            listener: (context, state) {
              if (state.errorMessage != null &&
                  state.errorMessage!.isNotEmpty) {
                ToastUtils.showError(state.errorMessage!);
              }
            },
            child: BlocBuilder<PolicyBloc, PolicyState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return const PolicySkeleton();
                }
                return const PolicyContentView();
              },
            ),
          ),
        ),
      ),
    );
  }
}

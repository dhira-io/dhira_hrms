import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/policy/presentation/cubit/policy_pdf_cubit.dart';
import 'package:dhira_hrms/features/policy/presentation/cubit/policy_pdf_state.dart';
import 'package:dhira_hrms/core/widgets/common_pdf_viewer.dart';
import 'package:provider/provider.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/features/policy/domain/usecases/get_policy_pdf_usecase.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class PolicyPdfBottomSheet extends StatelessWidget {
  const PolicyPdfBottomSheet({super.key});

  static void show(BuildContext context, PolicyEntity policy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Provider<PolicyEntity>.value(
          value: policy,
          child: BlocProvider(
            create: (_) => PolicyPdfCubit(Get.find<GetPolicyPdfUseCase>())..loadPdf(policy.fileUrl),
            child: const PolicyPdfBottomSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final policy = context.read<PolicyEntity>();
    return BlocBuilder<PolicyPdfCubit, PolicyPdfState>(
      builder: (context, state) {
        Uint8List? pdfBytes;
        String? errorMessage;
        if (state.status == PolicyPdfStatus.success && state.pdf != null) {
          try {
            pdfBytes = base64Decode(state.pdf!.fileBytes);
          } catch (e) {
            errorMessage = AppLocalizations.of(context)!.failedToLoadPdf;
          }
        } else if (state.status == PolicyPdfStatus.failure) {
          errorMessage = state.message ?? AppLocalizations.of(context)!.failedToLoadPdf;
        }

        return CommonPdfViewer(
          title: policy.title,
          pdfBytes: pdfBytes,
          isLoading: state.status == PolicyPdfStatus.loading || state.status == PolicyPdfStatus.initial,
          errorMessage: errorMessage,
          onRetry: () {
            context.read<PolicyPdfCubit>().loadPdf(policy.fileUrl);
          },
        );
      },
    );
  }
}

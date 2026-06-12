import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/policy/presentation/cubit/policy_pdf_cubit.dart';
import 'package:dhira_hrms/features/policy/presentation/cubit/policy_pdf_state.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:provider/provider.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/features/policy/domain/usecases/get_policy_pdf_usecase.dart';

class PolicyPdfBottomSheet extends StatefulWidget {
  const PolicyPdfBottomSheet({super.key});

  static void show(BuildContext context, PolicyEntity policy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.of(context).transparent,
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
  State<PolicyPdfBottomSheet> createState() => _PolicyPdfBottomSheetState();
}

class _PolicyPdfBottomSheetState extends State<PolicyPdfBottomSheet> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  int _totalPages = 0;
  int _currentPage = 0;
  int _rotationTurns = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppConstants.r20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p20,
              vertical: AppConstants.p10,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.of(context).slateText,
                  ),
                ),
                const SizedBox(width: AppConstants.p10),
                Expanded(
                  child: Text(
                    context.read<PolicyEntity>().title,
                    style: AppTextStyle.h3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.of(context).onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1.h),

          // PDF Viewer
          Expanded(
            child: BlocBuilder<PolicyPdfCubit, PolicyPdfState>(
              builder: (context, state) {
                switch (state.status) {
                  case PolicyPdfStatus.loading:
                    return const _PdfShimmerLoader();
                  case PolicyPdfStatus.success:
                    if (state.pdf == null) return const SizedBox.shrink();
                    try {
                      final bytes = base64Decode(state.pdf!.fileBytes);
                      return RotatedBox(
                        quarterTurns: _rotationTurns,
                        child: SfPdfViewer.memory(
                          bytes,
                          controller: _pdfViewerController,
                          canShowScrollHead: false,
                          canShowScrollStatus: false,
                          onDocumentLoaded: (details) {
                            setState(() {
                              _totalPages = details.document.pages.count;
                              _currentPage = 1;
                            });
                          },
                          onPageChanged: (details) {
                            setState(() {
                              _currentPage = details.newPageNumber;
                            });
                          },
                        ),
                      );
                    } catch (e) {
                      return Center(
                        child: Text(
                          l10n.failedToLoadPdf,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.of(context).onSurface,
                          ),
                        ),
                      );
                    }
                  case PolicyPdfStatus.failure:
                    return GenericErrorWidget(
                      onRetry: () {
                        context.read<PolicyPdfCubit>().loadPdf(context.read<PolicyEntity>().fileUrl);
                      },
                    );
                  case PolicyPdfStatus.initial:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),

          // Footer / Controls
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.p12,
              horizontal: AppConstants.p20,
            ),
            decoration: BoxDecoration(
              color: AppColors.of(context).surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.of(context).black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: _currentPage > 1
                        ? () => _pdfViewerController.previousPage()
                        : null,
                    icon: Icon(
                      Icons.chevron_left,
                      color: _currentPage > 1
                          ? AppColors.of(context).primary
                          : AppColors.of(context).placeholdergrey,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p12,
                      vertical: AppConstants.p6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).slate200,
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                    child: Text(
                      '$_currentPage / $_totalPages',
                      style: AppTextStyle.label.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.of(context).slateText,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    onPressed: _currentPage < _totalPages
                        ? () => _pdfViewerController.nextPage()
                        : null,
                    icon: Icon(
                      Icons.chevron_right,
                      color: _currentPage < _totalPages
                          ? AppColors.of(context).primary
                          : AppColors.of(context).slate400,
                    ),
                  ),
                  const Spacer(),
                  // Rotation Buttons
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rotationTurns = (_rotationTurns + 1) % 4;
                      });
                    },
                    icon: Icon(
                      Icons.rotate_left,
                      color: AppColors.of(context).slateText,
                    ),
                    tooltip: l10n.rotateLeft,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _rotationTurns = (_rotationTurns - 1) % 4;
                      });
                    },
                    icon: Icon(
                      Icons.rotate_right,
                      color: AppColors.of(context).slateText,
                    ),
                    tooltip: l10n.rotateRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PdfShimmerLoader extends StatelessWidget {
  const _PdfShimmerLoader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(width: double.infinity, height: 60.h),
          SizedBox(height: 20.h),
          ShimmerLoading(width: 250.w, height: 20.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: 200.w, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: 150.w, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),
          ShimmerLoading(width: double.infinity, height: 30.h),
          SizedBox(height: 10.h),

          ShimmerLoading(width: 220.w, height: 40.h),
        ],
      ),
    );
  }
}

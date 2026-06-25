import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/locale_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Map<String, String>> _getLanguages(AppLocalizations l10n) {
    return [
      {'code': 'en', 'name': l10n.english},
      {'code': 'hi', 'name': l10n.hindi},
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCubit = context.read<LocaleCubit>();
    final currentLocale = context.watch<LocaleCubit>().state;

    final filteredLanguages = _getLanguages(l10n).where((lang) {
      return lang['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.of(context).surfaceContainerLow,
      appBar: CommonAppBar(title: l10n.language),
      body: Padding(
        padding:       EdgeInsets.all(24.0.w),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: l10n.searchLanguage,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  contentPadding:       EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                style: AppTextStyle.bodyMedium,
              ),
            ),
                  SizedBox(height: 24.h),
            // Language List
            Container(
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.of(
                      context,
                    ).onSurface.withValues(alpha: 0.06),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: filteredLanguages.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.h,
                    indent: 24,
                    endIndent: 24,
                    color: AppColors.of(context).surfaceContainerHighest,
                  ),
                  itemBuilder: (context, index) {
                    final lang = filteredLanguages[index];
                    final isSelected =
                        currentLocale.languageCode == lang['code'];

                    return InkWell(
                      onTap: () {
                        localeCubit.changeLanguage(lang['code']!);
                      },
                      child: Padding(
                        padding:       EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lang['name']!,
                              style: AppTextStyle.bodyMedium.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: AppColors.of(context).onSurface,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: AppColors.of(context).primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

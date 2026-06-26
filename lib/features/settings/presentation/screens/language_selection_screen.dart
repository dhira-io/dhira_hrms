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
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        backgroundColor: AppColors.of(context).surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.of(context).onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.language,
          style: TextStyle(
            color: AppColors.of(context).onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.of(context).outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: l10n.searchLanguage,
                  hintStyle: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).outline,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.of(context).outline,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                style: AppTextStyle.bodyMedium,
              ),
            ),
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
              child: Text(
                l10n.availableLanguages.toUpperCase(),
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  fontSize: 12.sp,
                ),
              ),
            ),

            // Language List
            Container(
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.of(context).outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: List.generate(filteredLanguages.length, (index) {
                  final lang = filteredLanguages[index];
                  final isSelected = currentLocale.languageCode == lang['code'];
                  final showDivider = index < filteredLanguages.length - 1;

                  String subtitle = '';
                  if (lang['code'] == 'en') {
                    subtitle = 'English • United States';
                  } else if (lang['code'] == 'hi') {
                    subtitle = 'Hindi • India';
                  }

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          localeCubit.changeLanguage(lang['code']!);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang['name']!,
                                      style: AppTextStyle.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.of(context).onSurface,
                                      ),
                                    ),
                                    if (subtitle.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.h),
                                        child: Text(
                                          subtitle,
                                          style: AppTextStyle.bodySmall.copyWith(
                                            color: AppColors.of(context).outline,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 22.w,
                                height: 22.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF8B5CF6)
                                        : AppColors.of(context).outlineVariant,
                                    width: isSelected ? 6.w : 2.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (showDivider)
                        Divider(
                          height: 1.h,
                          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1),
                          indent: 16.w,
                          endIndent: 16.w,
                        ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

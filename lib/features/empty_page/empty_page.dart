import 'package:flutter/material.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/widgets/widgets.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    super.key,
    required this.title,
    required this.message,
    this.topBar,
  });

  final String title;
  final String message;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      topBar: topBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.emptyState.svg(),
          AppSpacings.s24.verticalSpace,
          AppText(
            title,
            style: AppTextStyles.headlineMedium,
            textAlign: TextAlign.center,
          ),
          AppSpacings.s16.verticalSpace,
          AppText(
            message,
            style: AppTextStyles.bodyDefault,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

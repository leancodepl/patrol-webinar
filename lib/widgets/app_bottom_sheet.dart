import 'package:flutter/material.dart' show showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, required this.title, required this.content});

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.colors.backgroundDefaultPrimary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: AppSpacings.s8.horizontal + AppSpacings.s8.top,
                child: AppButton.icon(
                  icon: AppStandardIcons.xClose,
                  type: AppButtonType.tertiary,
                  onTap: () => context.pop(),
                  semanticsLabel: s.common_close,
                  analyticsId: AnalyticsIds.bottomSheetCloseButton,
                ),
              ),
            ),
            Padding(
              padding: AppSpacings.s24.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title, AppSpacings.s12.verticalSpace, content],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    useRootNavigator: true,
    barrierColor: context.colors.backgroundDefaultScrim,
  );
}

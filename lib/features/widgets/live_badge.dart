import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/resources/strings.dart';

class LiveBadge extends StatelessWidget {
  const LiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    return Container(
      padding: AppSpacings.s8.horizontal + AppSpacings.s4.vertical,
      decoration: BoxDecoration(
        color: colors.backgroundDangerTertiary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colors.foregroundDangerPrimary,
              shape: BoxShape.circle,
            ),
          ),
          AppSpacings.s8.horizontalSpace,
          AppText(
            s.sessionTile_live,
            style: AppTextStyles.captionDefault,
            color: colors.foregroundDangerPrimary,
          ),
        ],
      ),
    );
  }
}

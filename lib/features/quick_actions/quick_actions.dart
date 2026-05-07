import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/resources/strings.dart';
import 'package:leancode_app_rating/leancode_app_rating.dart';
import 'package:quick_actions/quick_actions.dart';

enum QuickActionTypes { rate }

void registerQuickActions(BuildContext context) {
  const QuickActions()
    ..initialize((shortcutType) {
      if (shortcutType == QuickActionTypes.rate.name) {
        context.read<AppRating>().showStarDialog(context);
      }
    })
    ..setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: QuickActionTypes.rate.name,
        localizedTitle: l10n(context).quick_action_rate_title,
        localizedSubtitle: l10n(context).quick_action_rate_subtitle,
        icon: 'favorite',
      ),
    ]);
}

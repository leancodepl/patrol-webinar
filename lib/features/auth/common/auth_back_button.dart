import 'package:flutter/widgets.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final leading = AppTopBarAction.icon(
      icon: AppStandardIcons.chevronLeft,
      semanticsLabel: s.common_back,
      onTap: onTap,
    );

    return ColoredBox(
      color: colors.backgroundDefaultPrimary,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Padding(
          padding: AppSpacings.s8.vertical,
          child: TopBarAction(
            key: leading.key,
            icon: leading.icon,
            caption: leading.caption,
            type: leading.type,
            semanticsLabel: leading.semanticsLabel,
            onTap: leading.onTap,
            enabled: leading.enabled,
          ),
        ),
      ),
    );
  }
}

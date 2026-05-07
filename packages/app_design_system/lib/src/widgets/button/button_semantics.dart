import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ButtonSemantics extends StatelessWidget {
  const ButtonSemantics({
    super.key,
    required this.semanticsLabel,
    required this.caption,
    required this.enabled,
    required this.loading,
    required this.onTap,
    required this.child,
  });

  final String? semanticsLabel;
  final String? caption;
  final bool enabled;
  final bool loading;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveSemanticsLabel = switch (semanticsLabel ?? caption) {
      final label? => context.l10n.button_loadingSuffix(label),
      null => context.l10n.button_loading,
    };

    return Semantics(
      label: effectiveSemanticsLabel,
      container: true,
      button: true,
      enabled: enabled,
      onTap: enabled ? onTap : null,
      excludeSemantics: true,
      child: child,
    );
  }
}

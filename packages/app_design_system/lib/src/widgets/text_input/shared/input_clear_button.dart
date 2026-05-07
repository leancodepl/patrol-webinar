import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_button.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputClearButton extends StatelessWidget {
  const InputClearButton({
    super.key,
    required this.enabled,
    required this.onTap,
  });

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InputButton(
      spacing: AppSpacings.zero,
      variant: const InputButtonIcon(icon: AppStandardIcons.xCircle),
      enabled: enabled,
      onTap: onTap,
      semanticsLabel: context.l10n.textInput_clear,
      type: InputButtonType.base,
    );
  }
}

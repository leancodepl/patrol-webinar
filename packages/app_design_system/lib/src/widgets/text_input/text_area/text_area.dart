// We need these Material classes as base classes for our custom DS classes
// ignore_for_file: app_lint/use_design_system_item_AppColors_or_AppTextStyles, app_lint/use_design_system_item_AppTextField, app_lint/use_design_system_item_AppTextSpan

import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_border.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_external_decoration.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_help_button.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_labeled_decoration.dart';
import 'package:app_design_system/src/widgets/text_input/text_area/text_area_decoration.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _obscuringCharacter = '•';

const _textAreaStyle = AppTextStyles.bodyDefault;

// We don't have s10 in our spacings, so we use 10 explicitly
const _verticalPadding = EdgeInsetsDirectional.symmetric(vertical: 10);

class AppTextArea extends StatefulWidget {
  const AppTextArea({
    super.key,
    required this.decoration,
    this.enabled = true,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.obscureText = false,
    this.undoController,
    this.textAlign = TextAlign.start,
    this.obscuringCharacter = _obscuringCharacter,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.enableInteractiveSelection,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const [],
    this.contentInsertionConfiguration,
    this.stylusHandwritingEnabled = true,
    this.onTap,
    this.onTapOutside,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.maxLines,
    this.minLines = 3,
  });

  final AppTextAreaDecoration decoration;
  final bool enabled;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final UndoHistoryController? undoController;
  final TextAlign textAlign;
  final String? obscuringCharacter;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool? enableInteractiveSelection;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String> autofillHints;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final bool stylusHandwritingEnabled;
  final VoidCallback? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final int? maxLines;
  final int? minLines;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<AppTextAreaDecoration>('decoration', decoration),
      )
      ..add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: true))
      ..add(
        DiagnosticsProperty<FocusNode>(
          'focusNode',
          focusNode,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TextEditingController>(
          'controller',
          controller,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TextInputType>(
          'keyboardType',
          keyboardType,
          defaultValue: null,
        ),
      )
      ..add(
        EnumProperty<TextInputAction>(
          'textInputAction',
          textInputAction,
          defaultValue: null,
        ),
      )
      ..add(
        EnumProperty<TextCapitalization>(
          'textCapitalization',
          textCapitalization,
          defaultValue: TextCapitalization.none,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false),
      )
      ..add(
        DiagnosticsProperty<ValueChanged<String>>(
          'onChanged',
          onChanged,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<VoidCallback?>(
          'onEditingComplete',
          onEditingComplete,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<ValueChanged<String>>(
          'onSubmitted',
          onSubmitted,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<List<TextInputFormatter>>(
          'inputFormatters',
          inputFormatters,
          defaultValue: [],
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'obscureText',
          obscureText,
          defaultValue: false,
        ),
      )
      ..add(
        DiagnosticsProperty<UndoHistoryController>(
          'undoController',
          undoController,
          defaultValue: null,
        ),
      )
      ..add(
        EnumProperty<TextAlign>(
          'textAlign',
          textAlign,
          defaultValue: TextAlign.start,
        ),
      )
      ..add(
        DiagnosticsProperty<String>(
          'obscuringCharacter',
          obscuringCharacter,
          defaultValue: _obscuringCharacter,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'autocorrect',
          autocorrect,
          defaultValue: true,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'enableSuggestions',
          enableSuggestions,
          defaultValue: true,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'enableInteractiveSelection',
          enableInteractiveSelection,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<ScrollController>(
          'scrollController',
          scrollController,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<ScrollPhysics>(
          'scrollPhysics',
          scrollPhysics,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<Iterable<String>>(
          'autofillHints',
          autofillHints,
          defaultValue: [],
        ),
      )
      ..add(
        DiagnosticsProperty<ContentInsertionConfiguration>(
          'contentInsertionConfiguration',
          contentInsertionConfiguration,
          defaultValue: [],
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'stylusHandwritingEnabled',
          stylusHandwritingEnabled,
          defaultValue: true,
        ),
      )
      ..add(
        DiagnosticsProperty<VoidCallback>('onTap', onTap, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<void Function(PointerDownEvent)>(
          'onTapOutside',
          onTapOutside,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<String>(
          'restorationId',
          restorationId,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'enableIMEPersonalizedLearning',
          enableIMEPersonalizedLearning,
          defaultValue: true,
        ),
      )
      ..add(DiagnosticsProperty<int>('maxLines', maxLines, defaultValue: null))
      ..add(DiagnosticsProperty<int>('minLines', minLines, defaultValue: null));
  }

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode(debugLabel: 'AppTextArea'));

  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  AppTextAreaDecoration get _decoration => widget.decoration;

  @override
  void dispose() {
    _focusNode?.dispose();
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final decoration = material.InputDecoration(
      fillColor: colors.transparent,
      alignLabelWithHint: true,
      border: material.InputBorder.none,
      contentPadding: _verticalPadding,
      isCollapsed: true,
      isDense: true,
      hintText: _decoration.placeholder,
      hintStyle: _textAreaStyle.copyWith(color: colors.transparent),
      hintMaxLines: 1,
    );

    final textField = material.TextField(
      cursorColor: colors.foregroundActivePrimary,
      clipBehavior: Clip.none,
      textAlignVertical: TextAlignVertical.center,
      style: _textAreaStyle.copyWith(
        color: switch (widget.enabled) {
          true => colors.foregroundDefaultPrimary,
          false => colors.foregroundDisabledPrimary,
        },
      ),
      enabled: widget.enabled,
      focusNode: _effectiveFocusNode,
      controller: _effectiveController,
      decoration: decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText,
      undoController: widget.undoController,
      textAlign: widget.textAlign,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      restorationId: widget.restorationId,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
    );

    final labeledTextField = InputLabeledDecoration(
      enabled: widget.enabled,
      textField: textField,
      padding: _verticalPadding,
      focusNode: _effectiveFocusNode,
      controller: _effectiveController,
      textStyle: _textAreaStyle,
      label: _decoration.label,
      placeholder: _decoration.placeholder,
      help: _decoration.help,
      hint: _decoration.hint,
      error: _decoration.error,
      clearable: false,
      onClear: null,
    );

    // TODO: Add tooltip when it's ready
    //  https://linear.app/leancodepl/issue/DS-60/add-apptextfield-missing-parts
    final textFieldRow = ListenableBuilder(
      listenable: _effectiveController,
      builder: (context, _) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: labeledTextField),
          if (_decoration.help != null) ...[
            AppSpacings.s8.horizontalSpace,
            Padding(
              padding: _verticalPadding,
              child: ExcludeSemantics(
                child: InputHelpButton(
                  key: _decoration.helpKey,
                  enabled: widget.enabled,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ],
      ),
    );

    return InputExternalDecoration(
      enabled: widget.enabled,
      label: _decoration.label,
      hint: _decoration.hint,
      error: _decoration.error,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      child: InputBorder(
        focusNode: _effectiveFocusNode,
        error: _decoration.error != null,
        enabled: widget.enabled,
        child: Padding(
          padding: AppSpacings.s12.horizontal,
          child: textFieldRow,
        ),
      ),
    );
  }
}

// We need these Material classes as base classes for our custom DS classes
// ignore_for_file: app_lint/use_design_system_item_AppColors_or_AppTextStyles, app_lint/use_design_system_item_AppTextField, app_lint/use_design_system_item_AppTextSpan

import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/resolve_list_directionality.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_controller.dart';
import 'package:app_design_system/src/widgets/divider.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_border.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_external_decoration.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_help_button.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_icon.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_labeled_decoration.dart';
import 'package:app_design_system/src/widgets/text_input/text_field/text_field_decoration.dart';
import 'package:app_design_system/src/widgets/text_input/text_field/text_field_decoration_parts.dart';
import 'package:app_design_system/src/widgets/text_input/text_field/text_field_layout.dart';
import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _obscuringCharacter = '•';

const _textFieldStyle = AppTextStyles.bodyDefault;

class AppTextField extends StatefulWidget {
  const AppTextField({
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
  });

  final AppTextFieldDecoration decoration;
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<AppTextFieldDecoration>('decoration', decoration),
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
      );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ??
      (_focusNode ??= FocusNode(debugLabel: 'AppTextField'));

  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  AppTextFieldDecoration get _decoration => widget.decoration;

  final _leadingOptionController = AppContextMenuController();
  final _trailingOptionController = AppContextMenuController();

  @override
  void dispose() {
    _focusNode?.dispose();
    _controller?.dispose();

    _leadingOptionController.dispose();
    _trailingOptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textDirection = Directionality.of(context);

    final textScaler = MediaQuery.textScalerOf(context);

    final decoration = material.InputDecoration(
      fillColor: colors.transparent,
      alignLabelWithHint: true,
      border: material.InputBorder.none,
      contentPadding: _decoration.size.verticalPadding,
      isCollapsed: true,
      isDense: true,
      hintText: _decoration.placeholder,
      hintStyle: _textFieldStyle.copyWith(color: colors.transparent),
      hintMaxLines: 1,
    );

    final textField = material.TextField(
      cursorColor: colors.foregroundActivePrimary,
      cursorHeight: _getTextFieldHeight(textScaler),
      clipBehavior: Clip.none,
      textAlignVertical: TextAlignVertical.center,
      style: _textFieldStyle.copyWith(
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
    );

    final labeledTextField = _VisualTextFieldClipper(
      insets: _decoration.size.verticalPadding,
      child: InputLabeledDecoration(
        enabled: widget.enabled,
        textField: textField,
        padding: _decoration.size.verticalPadding,
        focusNode: _effectiveFocusNode,
        controller: _effectiveController,
        textStyle: _textFieldStyle,
        label: _decoration.label,
        placeholder: _decoration.placeholder,
        help: _decoration.help,
        hint: _decoration.hint,
        error: _decoration.error,
        clearable: _decoration.clearable,
        onClear: () => widget.onChanged?.call(''),
      ),
    );

    final horizontalSpace = BoxyId(
      hasData: true,
      data: TextFieldDecorationPartType.intrinsic,
      child: AppSpacings.s8.horizontalSpace,
    );

    final inlineDecorationParts = [
      if (_decoration.leadingIcon case final icon?) ...[
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.intrinsic,
          child: InputIcon(enabled: widget.enabled, icon: icon),
        ),
        horizontalSpace,
      ],
      if (_decoration.leadingOption case final option?) ...[
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.proportionable,
          child: Semantics(
            button: true,
            child: ListenableBuilder(
              listenable: _leadingOptionController,
              builder: (context, _) => TextFieldOption(
                key: option.key,
                enabled: widget.enabled,
                selected: _leadingOptionController.visible,
                text: option.label,
                onTap: _leadingOptionController.show,
              ),
            ),
          ),
        ),
        horizontalSpace,
      ],
      if (_decoration.prefix case final prefix?) ...[
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.proportionable,
          child: TextFieldAffixText(enabled: widget.enabled, text: prefix),
        ),
        horizontalSpace,
      ],
      BoxyId(
        id: labeledTextFieldSymbol,
        child: ListenableBuilder(
          listenable: _effectiveController,
          builder: (context, _) => labeledTextField,
        ),
      ),
      if (_decoration.suffix case final suffix?) ...[
        horizontalSpace,
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.proportionable,
          child: TextFieldAffixText(enabled: widget.enabled, text: suffix),
        ),
      ],
      if (_decoration.trailingOption case final option?) ...[
        horizontalSpace,
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.proportionable,
          child: Semantics(
            button: true,
            child: ListenableBuilder(
              listenable: _trailingOptionController,
              builder: (context, _) => TextFieldOption(
                key: option.key,
                enabled: widget.enabled,
                selected: _trailingOptionController.visible,
                text: option.label,
                onTap: _trailingOptionController.show,
              ),
            ),
          ),
        ),
      ],
      if (_decoration.trailingIcon case final icon?) ...[
        horizontalSpace,
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.intrinsic,
          child: InputIcon(enabled: widget.enabled, icon: icon),
        ),
      ],
      if (_decoration.action case final action?) ...[
        horizontalSpace,
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.intrinsic,
          child: Padding(
            padding: _decoration.size.verticalPadding,
            child: const AppDivider.vertical(),
          ),
        ),
        horizontalSpace,
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.proportionable,
          child: Semantics(
            button: true,
            child: TextFieldAction(
              key: action.key,
              enabled: widget.enabled,
              icon: action.icon,
              text: action.label,
              onTap: action.onTap,
            ),
          ),
        ),
      ],
      // TODO: Add tooltip when it's ready
      //  https://linear.app/leancodepl/issue/DS-60/add-apptextfield-missing-parts
      if (_decoration.help case final _?) ...[
        horizontalSpace,
        BoxyId(
          hasData: true,
          data: TextFieldDecorationPartType.intrinsic,
          child: ExcludeSemantics(
            child: InputHelpButton(
              key: _decoration.helpKey,
              enabled: widget.enabled,
              onTap: () {},
            ),
          ),
        ),
      ],
    ].resolve(textDirection);

    Widget inputContainer = InputBorder(
      focusNode: _effectiveFocusNode,
      error: _decoration.error != null,
      enabled: widget.enabled,
      child: Padding(
        padding: AppSpacings.s12.horizontal,
        child: CustomBoxy(
          delegate: TextFieldDecorationLayoutDelegate(),
          children: inlineDecorationParts,
        ),
      ),
    );

    if (_decoration.leadingOption?.items.isNotEmpty ?? false) {
      inputContainer = AppContextMenu(
        anchor: const AppContextMenuAnchor(
          target: AlignmentDirectional.bottomStart,
          menu: AlignmentDirectional.topStart,
        ),
        controller: _leadingOptionController,
        items: [...?_decoration.leadingOption?.items],
        child: inputContainer,
      );
    }

    if (_decoration.trailingOption?.items.isNotEmpty ?? false) {
      inputContainer = AppContextMenu(
        anchor: const AppContextMenuAnchor(
          target: AlignmentDirectional.bottomEnd,
          menu: AlignmentDirectional.topEnd,
        ),
        controller: _trailingOptionController,
        items: [...?_decoration.trailingOption?.items],
        child: inputContainer,
      );
    }

    return InputExternalDecoration(
      enabled: widget.enabled,
      label: _decoration.label,
      hint: _decoration.hint,
      error: _decoration.error,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      child: inputContainer,
    );
  }

  double _getTextFieldHeight(TextScaler textScaler) {
    return _textFieldStyle.height * textScaler.scale(_textFieldStyle.fontSize) +
        _decoration.size.verticalPadding.vertical;
  }
}

class _VisualTextFieldClipper extends SingleChildRenderObjectWidget {
  const _VisualTextFieldClipper({super.child, required this.insets});

  final EdgeInsetsDirectional insets;

  @override
  _RenderVisualTextFieldClipper createRenderObject(BuildContext context) =>
      _RenderVisualTextFieldClipper(
        clipper: _InsetsClipper(
          insets: insets.resolve(Directionality.of(context)),
        ),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderVisualTextFieldClipper renderObject,
  ) {
    renderObject.clipper = _InsetsClipper(
      insets: insets.resolve(Directionality.of(context)),
    );
  }
}

class _RenderVisualTextFieldClipper extends RenderClipRect {
  _RenderVisualTextFieldClipper({super.clipper})
    : super(clipBehavior: Clip.hardEdge);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return child!.hitTest(result, position: position);
  }
}

class _InsetsClipper extends CustomClipper<Rect> {
  const _InsetsClipper({required this.insets});

  final EdgeInsets insets;

  @override
  Rect getClip(Size size) {
    return insets.deflateRect(Offset.zero & size);
  }

  @override
  bool shouldReclip(_InsetsClipper oldClipper) => insets != oldClipper.insets;
}

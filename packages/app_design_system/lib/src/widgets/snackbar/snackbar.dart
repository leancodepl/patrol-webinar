import 'dart:async';

import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/global_key_extensions.dart';
import 'package:app_design_system/src/utils/page_transition_switcher.dart';
import 'package:app_design_system/src/widgets/button/text_button.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/snackbar/snackbar_entry.dart';
import 'package:app_design_system/src/widgets/snackbar/snackbar_theater.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'snackbar_scene.dart';
part 'snackbar_scene_registry.dart';
part 'snackbar_scene_reporter.dart';
part 'snackbar_switcher.dart';

enum AppSnackbarType {
  /// Doesn't show indicator (leading stripe) in the snackbar.
  neutral,
  info,
  success,
  warning,
  danger;

  AppColor? _getColor(AppColors colors) => switch (this) {
    neutral => null,
    info => colors.backgroundInfoPrimary,
    success => colors.backgroundSuccessPrimary,
    warning => colors.backgroundWarningPrimary,
    danger => colors.backgroundDangerPrimary,
  };
}

/// Layout of the snackbar.
enum AppSnackbarActionPosition {
  /// Action is placed next to the text.
  sideBySide,

  /// Action is placed below the text.
  below,
}

class AppSnackbarAction with EquatableMixin {
  const AppSnackbarAction({
    this.key,
    this.leadingIcon,
    required this.caption,
    this.trailingIcon,
    required this.onTap,
    this.position = AppSnackbarActionPosition.sideBySide,
  });

  final Key? key;
  final AppStandardIconData? leadingIcon;
  final String caption;
  final AppStandardIconData? trailingIcon;
  final VoidCallback onTap;
  final AppSnackbarActionPosition position;

  @override
  List<Object?> get props => [
    key,
    leadingIcon,
    caption,
    trailingIcon,
    onTap,
    position,
  ];
}

/// Snackbar used to show a temporary message to the user.
class AppSnackbar extends StatelessWidget {
  /// Creates an [AppSnackbar] widget.
  ///
  /// If the [onCloseTap] is omitted, but the [AppSnackbar] is displayed in an
  /// [AppSnackbarScene], then a close button will be inserted with a callback
  /// that removes the snackbar from the scene. This behavior can be turned off
  /// by setting [automaticallyImplyOnCloseTap] to false. In that case, a null
  /// [onCloseTap] will result in not showing the close button.
  const AppSnackbar({
    super.key,
    required this.type,
    this.icon,
    required this.text,
    required this.padding,
    this.action,
    this.onCloseTap,
    this.automaticallyImplyOnCloseTap = true,
  });

  /// Duration of the snackbar after which it is automatically closed.
  static const activeDuration = Duration(seconds: 4);

  final AppSnackbarType type;
  final AppStandardIconData? icon;
  final String text;
  final AppSnackbarAction? action;
  final EdgeInsets? padding;

  /// If this is null and [automaticallyImplyOnCloseTap] is set to true, the
  /// snackbar will imply a close button with appropriate callback that will
  /// remove current snackbar from the scene.
  final VoidCallback? onCloseTap;

  /// Controls whether we should try to imply the [onCloseTap].
  /// If true and [onCloseTap] is null, automatically use the [onCloseTap] that
  /// removes the related snackbar entry from the snackbar theater's queue.
  /// If false and [onCloseTap] is null, the space is given to the [text].
  /// If [onCloseTap] is not null, this parameter has no effect.
  final bool automaticallyImplyOnCloseTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final indicatorColor = type._getColor(colors);

    final crossAxisAlignment = switch (action?.position) {
      AppSnackbarActionPosition.below => CrossAxisAlignment.start,
      AppSnackbarActionPosition.sideBySide || null => CrossAxisAlignment.center,
    };

    final impliedOnCloseTap = AppSnackbarTheater.messengerOf(context).pop;

    final effectiveOnCloseTap = switch (onCloseTap) {
      final onCloseTap? => onCloseTap,
      null when automaticallyImplyOnCloseTap => impliedOnCloseTap,
      null => null,
    };

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Semantics(
        liveRegion: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colors.backgroundDefaultSecondary,
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.passthrough,
            children: [
              Padding(
                padding: AppSpacings.s16.vertical,
                child: Row(
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    if (icon case final icon?) ...[
                      AppSpacings.s16.horizontalSpace,
                      AppIcon(
                        icon,
                        size: AppStandardIconSize.s24,
                        color: colors.foregroundInfoSecondary,
                        semanticsLabel: null,
                      ),
                    ],
                    AppSpacings.s16.horizontalSpace,
                    Expanded(
                      child: _TextAndAction(text: text, action: action),
                    ),
                    AppSpacings.s16.horizontalSpace,
                    if (effectiveOnCloseTap case final onCloseTap?) ...[
                      _CloseButton(onCloseTap: onCloseTap),
                      AppSpacings.s16.horizontalSpace,
                    ],
                  ],
                ),
              ),
              if (indicatorColor case final color?)
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  bottom: 0,
                  child: _Indicator(color: color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.color});

  final AppColor color;

  @override
  Widget build(BuildContext context) {
    return Container(color: color, width: 8);
  }
}

class _TextAndAction extends StatelessWidget {
  const _TextAndAction({required this.text, required this.action});

  final String text;
  final AppSnackbarAction? action;

  @override
  Widget build(BuildContext context) {
    return switch (action?.position) {
      null => _Text(text: text),
      AppSnackbarActionPosition.sideBySide => Row(
        children: [
          Expanded(child: _Text(text: text)),
          if (action case final action?) ...[
            AppSpacings.s8.horizontalSpace,
            _ActionButton(action: action),
          ],
        ],
      ),
      AppSnackbarActionPosition.below => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Text(text: text),
          if (action case final action?) ...[
            AppSpacings.s8.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: _ActionButton(action: action),
            ),
          ],
        ],
      ),
    };
  }
}

class _Text extends StatelessWidget {
  const _Text({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: AppTextStyles.bodyDefault,
      color: context.colors.foregroundDefaultPrimary,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.action});

  final AppSnackbarAction action;

  @override
  Widget build(BuildContext context) {
    return AppRawTextButton(
      leadingIcon: action.leadingIcon,
      caption: action.caption,
      trailingIcon: action.trailingIcon,
      type: AppTextButtonType.brand,
      onTap: action.onTap,
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onCloseTap});

  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    return AppRawTextButton.icon(
      icon: AppStandardIcons.xClose,
      onTap: onCloseTap,
      type: AppTextButtonType.base,
      semanticsLabel: context.l10n.snackbar_close,
    );
  }
}

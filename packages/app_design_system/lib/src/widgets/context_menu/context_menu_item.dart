import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/utils/resolve_list_directionality.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_controller_provider.dart';
import 'package:app_design_system/src/widgets/divider.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:boxy/boxy.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const _duration = Duration(milliseconds: 250);

const _leadingIconSymbol = #leadingIcon;
const _titleSymbol = #title;
const _detailsSymbol = #details;
const _trailingIconSymbol = #trailingIcon;
const _chevronSymbol = #chevron;

@internal
class ContextMenuMaxIconCount extends InheritedWidget {
  const ContextMenuMaxIconCount({
    super.key,
    required super.child,
    required this.count,
  });

  final int count;

  static ContextMenuMaxIconCount? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ContextMenuMaxIconCount>();
  }

  @override
  bool updateShouldNotify(ContextMenuMaxIconCount oldWidget) {
    return count != oldWidget.count;
  }
}

sealed class AppContextMenuItem extends StatelessWidget {
  const factory AppContextMenuItem({
    Key? key,
    bool enabled,
    AppStandardIconData? leadingIcon,
    required String title,
    String? details,
    AppStandardIconData? trailingIcon,
    required VoidCallback onTap,
    bool parent,
  }) = ContextMenuItemDefault;

  const factory AppContextMenuItem.divider({Key? key}) = ContextMenuDivider;

  const AppContextMenuItem._({super.key});
}

@internal
final class ContextMenuDivider extends AppContextMenuItem {
  const ContextMenuDivider({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s8.vertical + AppSpacings.s16.horizontal,
      child: const AppDivider.horizontal(),
    );
  }
}

@internal
final class ContextMenuItemDefault extends AppContextMenuItem {
  const ContextMenuItemDefault({
    super.key,
    this.enabled = true,
    this.leadingIcon,
    required this.title,
    this.details,
    this.trailingIcon,
    required this.onTap,
    this.parent = false,
  }) : super._();

  final bool enabled;
  final AppStandardIconData? leadingIcon;
  final String title;
  final String? details;
  final AppStandardIconData? trailingIcon;
  final VoidCallback onTap;

  /// Whether context menu item should spawn chevron at the end of itself.
  final bool parent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textDirection = Directionality.of(context);

    final controller = ContextMenuControllerProvider.maybeOf(context);

    void onTap() {
      controller?.hide();
      this.onTap();
    }

    var iconCount = 0;
    if (trailingIcon != null) {
      iconCount++;
    }
    if (parent) {
      iconCount++;
    }

    final maxIconCount =
        ContextMenuMaxIconCount.maybeOf(context)?.count ?? iconCount;

    final iconCountDifference = maxIconCount - iconCount;

    final placeholderWidth =
        (AppStandardIconSize.s24.size.width + AppSpacings.s8.value) *
        iconCountDifference;

    return AppPointerSurface(
      enabled: enabled,
      onTap: onTap,
      builder: (context, states) {
        final titleColor = _getTitleColor(
          colors,
          states: states,
          enabled: enabled,
        );
        final backgroundColor = _getBackgroundColor(
          colors,
          states: states,
          enabled: enabled,
        );
        final optionalElementsColor = _getOptionalElementsColor(
          colors,
          states: states,
          enabled: enabled,
        );

        return _ColorsTween(
          titleColor: titleColor,
          backgroundColor: backgroundColor,
          optionalElementsColor: optionalElementsColor,
          builder:
              (context, titleColor, backgroundColor, optionalElementsColor) {
                final children = [
                  if (leadingIcon case final icon?)
                    BoxyId(
                      id: _leadingIconSymbol,
                      child: Padding(
                        padding: AppSpacings.s8.end,
                        child: AppIcon(
                          icon,
                          size: AppStandardIconSize.s24,
                          color: optionalElementsColor,
                          semanticsLabel: null,
                        ),
                      ),
                    ),
                  BoxyId(
                    id: _titleSymbol,
                    child: AppText(
                      title,
                      style: AppTextStyles.bodyDefault,
                      color: titleColor,
                    ),
                  ),
                  if (details case final details?)
                    BoxyId(
                      id: _detailsSymbol,
                      child: Padding(
                        padding: AppSpacings.s8.start,
                        child: AppText(
                          details,
                          style: AppTextStyles.bodyDefault,
                          color: optionalElementsColor,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  if (trailingIcon case final trailingIcon?)
                    BoxyId(
                      id: _trailingIconSymbol,
                      child: Padding(
                        padding: AppSpacings.s8.start,
                        child: AppIcon(
                          trailingIcon,
                          size: AppStandardIconSize.s24,
                          color: optionalElementsColor,
                          semanticsLabel: null,
                        ),
                      ),
                    ),
                  if (parent)
                    BoxyId(
                      id: _chevronSymbol,
                      child: Padding(
                        padding: AppSpacings.s8.start,
                        child: AppIcon(
                          switch (textDirection) {
                            TextDirection.ltr => AppStandardIcons.chevronRight,
                            TextDirection.rtl => AppStandardIcons.chevronLeft,
                          },
                          size: AppStandardIconSize.s24,
                          color: optionalElementsColor,
                          semanticsLabel:
                              context.l10n.contextMenuItem_containsMoreItems,
                        ),
                      ),
                    ),
                ];

                return Container(
                  padding:
                      AppSpacings.s16.horizontal + AppSpacings.s12.vertical,
                  color: backgroundColor,
                  child: CustomBoxy(
                    delegate: _ItemLayoutDelegate(
                      textDirection: textDirection,
                      placeholderWidth: placeholderWidth,
                    ),
                    children: children,
                  ),
                );
              },
        );
      },
    );
  }

  AppColor _getTitleColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool enabled,
  }) {
    if (!enabled) {
      return colors.foregroundDisabledPrimary;
    }

    return colors.foregroundDefaultPrimary;
  }

  AppColor _getBackgroundColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool enabled,
  }) {
    if (!enabled) {
      return colors.backgroundDisabledTertiary;
    }

    return switch (states) {
      Set(containsPressed: true) => colors.backgroundDefaultPrimaryPressed,
      _ => colors.transparent,
    };
  }

  AppColor _getOptionalElementsColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool enabled,
  }) {
    if (!enabled) {
      return colors.foregroundDisabledSecondary;
    }

    return colors.foregroundDefaultSecondary;
  }
}

typedef _ColorsTweenBuilder =
    Widget Function(
      BuildContext context,
      AppColor titleColor,
      AppColor backgroundColor,
      AppColor optionalElementsColor,
    );

class _ColorsTween extends ImplicitlyAnimatedWidget {
  const _ColorsTween({
    required this.titleColor,
    required this.backgroundColor,
    required this.optionalElementsColor,
    required this.builder,
  }) : super(duration: _duration, curve: Curves.easeOutQuart);

  final AppColor titleColor;
  final AppColor backgroundColor;
  final AppColor optionalElementsColor;
  final _ColorsTweenBuilder builder;

  @override
  _ColorsTweenState createState() => _ColorsTweenState();
}

class _ColorsTweenState extends AnimatedWidgetBaseState<_ColorsTween> {
  AppColorTween? _titleColor;
  AppColorTween? _backgroundColor;
  AppColorTween? _optionalElementsColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _titleColor =
        visitor(
              _titleColor,
              widget.titleColor,
              (dynamic value) =>
                  AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _backgroundColor =
        visitor(
              _backgroundColor,
              widget.backgroundColor,
              (dynamic value) =>
                  AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _optionalElementsColor =
        visitor(
              _optionalElementsColor,
              widget.optionalElementsColor,
              (dynamic value) =>
                  AppColorTween.uniform(value as AppColor)..end = null,
            )
            as AppColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _titleColor!.evaluate(animation),
      _backgroundColor!.evaluate(animation),
      _optionalElementsColor!.evaluate(animation),
    );
  }
}

typedef _ItemLayoutData = ({
  double leadingIconWidth,
  double titleWidth,
  double detailsWidth,
  double trailingIconWidth,
  double chevronWidth,
});

class _ItemLayoutDelegate extends BoxyDelegate {
  _ItemLayoutDelegate({
    required this.textDirection,
    required this.placeholderWidth,
  });

  final TextDirection textDirection;
  final double placeholderWidth;

  BoxyChild? get leadingIcon => getChildOrNull(_leadingIconSymbol);
  BoxyChild get title => getChild(_titleSymbol);
  BoxyChild? get details => getChildOrNull(_detailsSymbol);
  BoxyChild? get trailingIcon => getChildOrNull(_trailingIconSymbol);
  BoxyChild? get chevron => getChildOrNull(_chevronSymbol);

  @override
  Size layout() {
    final width = constraints.maxWidth;
    final maxHeight = constraints.maxHeight;

    final (
      :leadingIconWidth,
      :titleWidth,
      :detailsWidth,
      :trailingIconWidth,
      :chevronWidth,
    ) = _getLayoutData(
      width: width,
      height: maxHeight,
    );

    final leadingChildren = [
      if (leadingIcon case final leadingIcon?)
        (widget: leadingIcon, width: leadingIconWidth),
      (widget: title, width: titleWidth),
    ].resolve(textDirection);

    final trailingChildren = [
      if (details case final details?) (widget: details, width: detailsWidth),
      if (trailingIcon case final trailingIcon?)
        (widget: trailingIcon, width: trailingIconWidth),
      if (chevron case final chevron?) (widget: chevron, width: chevronWidth),
    ].resolve(textDirection);

    final (:leftChildren, :rightChildren) = switch (textDirection) {
      TextDirection.ltr => (
        leftChildren: leadingChildren,
        rightChildren: trailingChildren,
      ),
      TextDirection.rtl => (
        leftChildren: trailingChildren,
        rightChildren: leadingChildren,
      ),
    };

    for (final child in leftChildren) {
      child.widget.layout(constraints.loosen().copyWith(maxWidth: child.width));
    }

    for (final child in rightChildren.reversed) {
      child.widget.layout(constraints.loosen().copyWith(maxWidth: child.width));
    }

    final height = children.map((child) => child.size.height).max;

    var currentLeft = 0.0;
    for (final child in leftChildren) {
      final offset = Offset(
        currentLeft,
        (height - child.widget.size.height) / 2,
      );
      child.widget.position(offset);
      currentLeft += child.widget.size.width;
    }

    currentLeft = width;
    for (final child in rightChildren.reversed) {
      currentLeft -= child.widget.size.width;
      final offset = Offset(
        currentLeft,
        (height - child.widget.size.height) / 2,
      );
      child.widget.position(offset);
    }

    return Size(width, height);
  }

  _ItemLayoutData _getLayoutData({
    required double width,
    required double height,
  }) {
    final details = this.details;
    final constraints = BoxConstraints(maxWidth: width, maxHeight: height);

    final leadingIconWidth =
        leadingIcon?.render.getDryLayout(constraints).width ?? 0;

    final titleIntrinsicWidth = title.render.getMaxIntrinsicWidth(height);

    final detailsIntrinsicWidth =
        details?.render.getMaxIntrinsicWidth(height) ?? 0;

    final trailingIconWidth =
        trailingIcon?.render.getDryLayout(constraints).width ?? 0;

    final chevronWidth = chevron?.render.getDryLayout(constraints).width ?? 0;

    final totalTextIntrinsicWidth = titleIntrinsicWidth + detailsIntrinsicWidth;

    final totalIntrinsicWidth =
        leadingIconWidth +
        titleIntrinsicWidth +
        detailsIntrinsicWidth +
        trailingIconWidth +
        chevronWidth +
        placeholderWidth;

    final maxTextWidth =
        width -
        leadingIconWidth -
        trailingIconWidth -
        chevronWidth -
        placeholderWidth;

    var titleWidth = titleIntrinsicWidth;
    var detailsWidth = detailsIntrinsicWidth;

    if (maxTextWidth.isFinite) {
      if (detailsWidth / maxTextWidth < 0.5) {
        titleWidth = maxTextWidth - detailsWidth;
      } else if (titleWidth / maxTextWidth < 0.5) {
        detailsWidth = maxTextWidth - titleWidth;
      } else if (totalIntrinsicWidth > width && totalTextIntrinsicWidth > 0) {
        titleWidth =
            maxTextWidth * titleIntrinsicWidth / totalTextIntrinsicWidth;
        detailsWidth =
            maxTextWidth * detailsIntrinsicWidth / totalTextIntrinsicWidth;

        if (details != null) {
          if (titleWidth / maxTextWidth < 0.2) {
            titleWidth = maxTextWidth * 0.2;
            detailsWidth = maxTextWidth - titleWidth;
          } else if (detailsWidth / maxTextWidth < 0.2) {
            detailsWidth = maxTextWidth * 0.2;
            titleWidth = maxTextWidth - detailsWidth;
          }
        }
      }
    }

    return (
      leadingIconWidth: leadingIconWidth,
      titleWidth: titleWidth,
      detailsWidth: detailsWidth,
      trailingIconWidth: trailingIconWidth,
      chevronWidth: chevronWidth,
    );
  }

  @override
  double minIntrinsicWidth(double height) {
    final (
      :leadingIconWidth,
      titleWidth: _,
      detailsWidth: _,
      :trailingIconWidth,
      :chevronWidth,
    ) = _getLayoutData(
      width: double.infinity,
      height: height,
    );

    return leadingIconWidth +
        trailingIconWidth +
        chevronWidth +
        placeholderWidth;
  }

  @override
  double maxIntrinsicWidth(double height) {
    final (
      :leadingIconWidth,
      :titleWidth,
      :detailsWidth,
      :trailingIconWidth,
      :chevronWidth,
    ) = _getLayoutData(
      width: double.infinity,
      height: height,
    );

    return leadingIconWidth +
        titleWidth +
        detailsWidth +
        trailingIconWidth +
        chevronWidth +
        placeholderWidth;
  }

  @override
  double minIntrinsicHeight(double width) {
    return maxIntrinsicHeight(width);
  }

  @override
  double maxIntrinsicHeight(double width) {
    final constraints = BoxConstraints(maxWidth: width);

    final (
      leadingIconWidth: _,
      :titleWidth,
      :detailsWidth,
      trailingIconWidth: _,
      chevronWidth: _,
    ) = _getLayoutData(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
    );

    final leadingIconHeight =
        leadingIcon?.render.getDryLayout(constraints).height ?? 0;

    final titleIntrinsicHeight = title.render.getMaxIntrinsicHeight(titleWidth);

    final detailsIntrinsicHeight =
        details?.render.getMaxIntrinsicHeight(detailsWidth) ?? 0;

    final trailingIconHeight =
        trailingIcon?.render.getDryLayout(constraints).height ?? 0;

    final chevronHeight = chevron?.render.getDryLayout(constraints).height ?? 0;

    return [
      leadingIconHeight,
      titleIntrinsicHeight,
      detailsIntrinsicHeight,
      trailingIconHeight,
      chevronHeight,
    ].max;
  }

  @override
  bool shouldRelayout(_ItemLayoutDelegate oldDelegate) =>
      textDirection != oldDelegate.textDirection ||
      placeholderWidth != oldDelegate.placeholderWidth;
}

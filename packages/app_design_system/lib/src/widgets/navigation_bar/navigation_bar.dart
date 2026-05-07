import 'dart:math';

import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/config.dart';
import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/utils/resolve_list_directionality.dart';
import 'package:boxy/boxy.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

export 'navigation_bar_controller.dart';
export 'navigation_bar_view.dart';

final class AppNavigationBarItem with EquatableMixin {
  const AppNavigationBarItem({
    this.key,
    required this.title,
    this.badge = false,
    required this.icon,
    this.selectedColor,
  });

  final Key? key;
  final String title;
  final bool badge;
  final AppStandardIcons icon;
  final AppColor? selectedColor;

  @override
  List<Object?> get props => [key, title, badge, icon];
}

class AppNavigationBar extends StatefulWidget {
  AppNavigationBar({
    super.key,
    required this.controller,
    this.divider = true,
    required this.items,
  }) : assert(controller.totalPages == items.length);

  final AppNavigationBarController controller;
  final bool divider;
  final List<AppNavigationBarItem> items;

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: widget.divider
              ? BorderSide(color: context.colors.foregroundDefaultQuaternary)
              : BorderSide.none,
        ),
      ),
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: CustomBoxy(
          delegate: _ItemsDelegate(),
          children: widget.items
              .mapIndexed(
                (index, item) => AnimatedBuilder(
                  key: item.key,
                  animation: widget.controller,
                  builder: (context, child) => _Item(
                    title: item.title,
                    icon: item.icon,
                    selected: index == widget.controller.current,
                    badge: item.badge,
                    onTap: () => widget.controller.changePage(index),
                    semanticsIndex: index + 1,
                    semanticsTotalItems: widget.items.length,
                    selectedColor: item.selectedColor,
                  ),
                ),
              )
              .toList()
              .resolve(textDirection),
        ),
      ),
    );
  }
}

class _ItemsDelegate extends BoxyDelegate {
  @override
  Size layout() {
    final childrenWidths = children
        .map(
          (child) => child.render.getMinIntrinsicWidth(constraints.maxHeight),
        )
        .toList();

    final childrenWidthSum = childrenWidths.sum;

    final totalNavigationBarWidth = constraints.maxWidth;
    final preferredChildWidth = totalNavigationBarWidth / children.length;

    final allChildrenFitEqually = childrenWidths.every(
      (childWidth) => childWidth <= preferredChildWidth,
    );

    var currentMaxItemHeight = 0.0;

    if (allChildrenFitEqually ||
        !AppConfig.navBarItemsRatioSizingForLongCaptions) {
      children.forEachIndexed((index, child) {
        child
          ..layout(
            constraints.copyWith(
              minWidth: preferredChildWidth,
              maxWidth: preferredChildWidth,
            ),
          )
          ..position(Offset(index * preferredChildWidth, 0));

        currentMaxItemHeight = max(currentMaxItemHeight, child.size.height);
      });
    } else {
      var previousItemsWidth = 0.0;

      for (var index = 0; index < children.length; index++) {
        final ratio = childrenWidths[index] / childrenWidthSum;

        final itemWidth = totalNavigationBarWidth * ratio;

        final child = children[index]
          ..layout(
            constraints.copyWith(minWidth: itemWidth, maxWidth: itemWidth),
          )
          ..position(Offset(previousItemsWidth, 0));

        previousItemsWidth += child.size.width;
        currentMaxItemHeight = max(currentMaxItemHeight, child.size.height);
      }
    }

    return Size(totalNavigationBarWidth, currentMaxItemHeight);
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.icon,
    required this.selected,
    required this.badge,
    required this.onTap,
    required this.semanticsIndex,
    required this.semanticsTotalItems,
    this.selectedColor,
  });

  final String title;
  final AppStandardIcons icon;
  final bool selected;
  final bool badge;
  final VoidCallback onTap;
  final int semanticsIndex;
  final int semanticsTotalItems;
  final AppColor? selectedColor;

  static const duration = Duration(milliseconds: 250);
  static const curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return Semantics(
      button: true,
      container: true,
      selected: selected,
      child: AppPointerSurface(
        enabled: true,
        onTap: onTap,
        builder: (context, states) {
          return TweenAnimationBuilder(
            tween: AppColorTween.uniform(_getColor(colors, states: states)),
            curve: curve,
            duration: duration,
            builder: (context, color, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: AppSpacings.s16.horizontal,
                  width: double.infinity,
                  height: 2,
                  child: ColoredBox(
                    color: switch (selected) {
                      true => color,
                      false => colors.transparent,
                    },
                  ),
                ),
                Padding(
                  padding: AppSpacings.s8.all,
                  child: Column(
                    children: [
                      ExcludeSemantics(
                        child: _ItemIcon(
                          title: title,
                          icon: icon,
                          selected: selected,
                          displayBadge: badge,
                          color: color,
                        ),
                      ),
                      AppSpacings.s8.verticalSpace,
                      AppText(
                        title,
                        style: AppTextStyles.captionDefault,
                        color: color,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        ellipsis: false,
                      ),
                      Semantics(
                        label: l10n.navigationBar_tabOfTotal(
                          semanticsIndex,
                          semanticsTotalItems,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppColor _getColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
  }) {
    return switch (states) {
      Set(containsPressed: true) => colors.foregroundActivePrimaryPressed,
      _ => switch (selected) {
        true => selectedColor ?? colors.foregroundActivePrimary,
        false => colors.foregroundDefaultSecondary,
      },
    };
  }
}

class _ItemIcon extends StatelessWidget {
  const _ItemIcon({
    required this.title,
    required this.icon,
    required this.selected,
    required this.displayBadge,
    required this.color,
  });

  final String title;
  final AppStandardIcons icon;
  final bool selected;
  final bool displayBadge;
  final AppColor color;

  static const _badgeSize = 12.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppIcon(
          icon,
          size: AppStandardIconSize.s24,
          color: color,
          semanticsLabel: null,
        ),
        PositionedDirectional(
          top: -AppSpacings.s8.value,
          end: -AppSpacings.s8.value,
          child: Container(
            height: _badgeSize,
            width: _badgeSize,
            alignment: Alignment.center,
            margin: AppSpacings.s4.all,
            child: TweenAnimationBuilder(
              tween: Tween<double>(end: displayBadge ? 12 : 0),
              curve: _Item.curve,
              duration: _Item.duration,
              builder: (context, size, _) => Container(
                height: size,
                width: size,
                decoration: ShapeDecoration(
                  shape: const OvalBorder(),
                  color: context.colors.foregroundDangerPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

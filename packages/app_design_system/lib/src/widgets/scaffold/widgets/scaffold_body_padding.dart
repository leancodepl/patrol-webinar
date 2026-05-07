import 'dart:math';

import 'package:app_design_system/src/widgets/scaffold/scaffold.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ChildScaffoldBodyPadding extends StatelessWidget {
  const ChildScaffoldBodyPadding({
    super.key,
    required this.body,
    required this.bottomSegmentHeight,
    required this.footerOnTop,
    required this.hasTopBar,
    required this.hasFooter,
    required this.useBodyPadding,
    required this.useSafeArea,
  });

  final Widget body;
  final PinnedBottomSegmentHeight bottomSegmentHeight;
  final bool footerOnTop;
  final bool hasTopBar;
  final bool hasFooter;
  final bool useBodyPadding;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final contentPadding = _resolveContentPadding(context);
    final padding = _resolveMediaQueryPadding(context);
    final viewInset = _resolveViewInset(context);

    return Padding(
      padding: contentPadding,
      child: MediaQuery(
        data: mediaQuery.copyWith(padding: padding, viewInsets: viewInset),
        child: body,
      ),
    );
  }

  EdgeInsets _resolveMediaQueryPadding(BuildContext context) {
    var effectiveSafeArea = EdgeInsets.zero;

    final safePadding = MediaQuery.paddingOf(context);

    if (!useSafeArea) {
      effectiveSafeArea += EdgeInsets.only(
        left: safePadding.left,
        right: safePadding.right,
      );

      if (!hasTopBar && !useSafeArea) {
        effectiveSafeArea += EdgeInsets.only(top: safePadding.top);
      }
    }

    if (hasFooter && footerOnTop) {
      effectiveSafeArea += EdgeInsets.only(
        bottom: bottomSegmentHeight.totalHeight,
      );
    } else if (!hasFooter && !useSafeArea) {
      effectiveSafeArea += EdgeInsets.only(bottom: safePadding.bottom);
    }

    return effectiveSafeArea;
  }

  EdgeInsets _resolveViewInset(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final pinnedFooterHeight = bottomSegmentHeight.pinnedFooterHeight ?? 0;
    final remainingBottomInset = max<double>(
      0,
      mediaQuery.viewInsets.bottom - pinnedFooterHeight,
    );

    return mediaQuery.viewInsets.copyWith(bottom: remainingBottomInset);
  }

  EdgeInsets _resolveContentPadding(BuildContext context) {
    var effectivePadding = EdgeInsets.zero;

    final safePadding = MediaQuery.paddingOf(context);

    if (bottomSegmentHeight.pinnedFooterHeight case final pinnedFooterHeight?
        when !footerOnTop) {
      effectivePadding += EdgeInsets.only(bottom: pinnedFooterHeight);
    }

    if (useSafeArea) {
      effectivePadding += EdgeInsets.only(
        left: safePadding.left,
        right: safePadding.right,
      );

      if (!hasTopBar) {
        effectivePadding += EdgeInsets.only(top: safePadding.top);
      }

      if (!footerOnTop) {
        final deviceBottomSafeArea = hasFooter ? 0.0 : safePadding.bottom;

        final clearOfFabPadding = bottomSegmentHeight.paddedFabHeight ?? 0.0;

        effectivePadding += EdgeInsets.only(
          bottom: clearOfFabPadding + deviceBottomSafeArea,
        );
      }
    }

    if (useBodyPadding) {
      final resolvedBodyPadding = AppScaffold.bodyPadding.all.resolve(
        Directionality.of(context),
      );

      effectivePadding += resolvedBodyPadding;
    }

    return effectivePadding;
  }
}

@internal
class SliverScaffoldBodyPadding extends StatelessWidget {
  const SliverScaffoldBodyPadding({
    super.key,
    required this.sliverBody,
    required this.bottomSegmentHeight,
    required this.footerBehavior,
    required this.hasTopBar,
    required this.hasPinnedFooter,
    required this.hasContentFooter,
    required this.hasScrollExtent,
    required this.useBodyPadding,
    required this.useSafeArea,
    required this.didOverscrollBottom,
  });

  final Widget sliverBody;
  final PinnedBottomSegmentHeight bottomSegmentHeight;
  final AppScaffoldFooterBehavior footerBehavior;
  final bool hasTopBar;
  final bool hasPinnedFooter;
  final bool hasContentFooter;
  final bool hasScrollExtent;
  final bool useBodyPadding;
  final bool useSafeArea;
  final bool didOverscrollBottom;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final resolvedBodyPadding = _resolveContentPadding(context);

    final updatedSafeArea = switch (useSafeArea) {
      true => EdgeInsets.only(top: hasTopBar ? 0 : mediaQuery.padding.top),
      false =>
        mediaQuery.padding.copyWith(
              top: hasTopBar ? 0 : mediaQuery.padding.top,
            ) +
            EdgeInsets.only(bottom: bottomSegmentHeight.paddedFabHeight ?? 0),
    };

    return SliverPadding(
      padding: resolvedBodyPadding,
      sliver: MediaQuery(
        data: mediaQuery.copyWith(padding: updatedSafeArea),
        child: sliverBody,
      ),
    );
  }

  EdgeInsets _resolveContentPadding(BuildContext context) {
    var effectivePadding = EdgeInsets.zero;

    final hasAnyFooter = hasPinnedFooter || hasContentFooter;

    if (bottomSegmentHeight.pinnedFooterHeight case final pinnedFooterHeight?) {
      final clearOfFooterPadding = switch (footerBehavior) {
        AppScaffoldFooterBehavior.bottomPushed => 0.0,
        _ => pinnedFooterHeight,
      };

      effectivePadding += EdgeInsets.only(bottom: clearOfFooterPadding);
    }

    if (useSafeArea) {
      final safeAreaPadding = MediaQuery.paddingOf(context);

      final double deviceBottomSafeArea;
      if (hasContentFooter) {
        deviceBottomSafeArea = switch (footerBehavior) {
          AppScaffoldFooterBehavior.bottomPushed => 0.0,
          AppScaffoldFooterBehavior.endPinned when !hasScrollExtent => 0.0,
          AppScaffoldFooterBehavior.endPinned when didOverscrollBottom => 0.0,
          _ => safeAreaPadding.bottom,
        };
      } else if (hasPinnedFooter) {
        deviceBottomSafeArea = 0.0;
      } else {
        deviceBottomSafeArea = safeAreaPadding.bottom;
      }

      effectivePadding += safeAreaPadding.copyWith(
        bottom: deviceBottomSafeArea,
      );

      final clearOfFabPadding = switch (footerBehavior) {
        AppScaffoldFooterBehavior.endPinned when hasAnyFooter => 0.0,
        AppScaffoldFooterBehavior.bottomPushed when hasContentFooter => 0.0,
        _ => bottomSegmentHeight.paddedFabHeight ?? 0.0,
      };

      effectivePadding += EdgeInsets.only(bottom: clearOfFabPadding);
    }

    if (useBodyPadding) {
      final resolvedBodyPadding = AppScaffold.bodyPadding.all.resolve(
        Directionality.of(context),
      );

      effectivePadding += resolvedBodyPadding;
    }

    return effectivePadding;
  }
}

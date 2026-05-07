import 'package:app_design_system/src/widgets/scaffold/scaffold.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:flutter/material.dart' show RefreshCallback, RefreshIndicator;
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({
    super.key,
    required this.didOverscrollBottom,
    required this.scrollController,
    this.physics,
    required this.sliverContent,
    this.pinnedBottomSegmentHeight,
    required this.footerBehavior,
    this.footerBuilder,
    this.onRefresh,
  });

  final bool didOverscrollBottom;
  final ScrollController scrollController;
  final ScrollPhysics? physics;
  final Widget sliverContent;
  final PinnedBottomSegmentHeight? pinnedBottomSegmentHeight;
  final AppScaffoldFooterBehavior footerBehavior;
  final AppScaffoldFooterBuilder? footerBuilder;
  final RefreshCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.paddingOf(context);

    return ConditionalWrapper.nonNull(
      value: onRefresh,
      wrapperBuilder: (child, onRefresh) =>
          RefreshIndicator(onRefresh: onRefresh, child: child),
      child: CustomScrollView(
        controller: scrollController,
        physics: physics,
        slivers: [
          sliverContent,
          if (footerBuilder case final contentFooterBuilder?
              when footerBehavior != AppScaffoldFooterBehavior.bottomPinned)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: switch (footerBehavior) {
                  AppScaffoldFooterBehavior.endPinned =>
                    AlignmentDirectional.topCenter,
                  AppScaffoldFooterBehavior.bottomPushed =>
                    AlignmentDirectional.bottomCenter,
                  AppScaffoldFooterBehavior.bottomPinned =>
                    throw UnsupportedError('Unreachable case'),
                },
                child: SizedBox(
                  width: double.infinity,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeBottom: true,
                    removeLeft: true,
                    removeRight: true,
                    child: contentFooterBuilder(
                      context,
                      false,
                      safePadding.copyWith(top: 0),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

@internal
class ConditionalWrapper extends StatelessWidget {
  const ConditionalWrapper({
    super.key,
    required this.condition,
    required this.wrapperBuilder,
    required this.child,
  });

  static ConditionalWrapper nonNull<T extends Object>({
    Key? key,
    required T? value,
    required Widget Function(Widget child, T value) wrapperBuilder,
    required Widget child,
  }) {
    return ConditionalWrapper(
      key: key,
      condition: value != null,
      wrapperBuilder: (child) => wrapperBuilder(child, value!),
      child: child,
    );
  }

  final bool condition;
  final Widget Function(Widget child) wrapperBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return condition ? wrapperBuilder(child) : child;
  }
}

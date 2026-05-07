import 'package:app_design_system/src/widgets/scaffold/scaffold.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/scaffold_body.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/scaffold_body_padding.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/scaffold_content_scroll_listener.dart';
import 'package:flutter/material.dart' show RefreshCallback;
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ScrollableScaffoldDelegate extends StatefulWidget {
  const ScrollableScaffoldDelegate({
    super.key,
    this.scrollController,
    this.physics,
    required this.hasTopBar,
    required this.useSafeArea,
    required this.useBodyPadding,
    required this.sliverContent,
    this.floatingActionButton,
    required this.footerBehavior,
    this.footerBuilder,
    this.onRefresh,
  });

  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final bool hasTopBar;
  final bool useSafeArea;
  final bool useBodyPadding;
  final Widget sliverContent;
  final Widget? floatingActionButton;
  final AppScaffoldFooterBehavior footerBehavior;
  final AppScaffoldFooterBuilder? footerBuilder;
  final RefreshCallback? onRefresh;

  @override
  State<ScrollableScaffoldDelegate> createState() =>
      _ScrollableScaffoldDelegateState();
}

class _ScrollableScaffoldDelegateState
    extends State<ScrollableScaffoldDelegate> {
  ScrollController get _effectiveScrollController =>
      widget.scrollController ??
      (_scrollController ??= ScrollController(
        debugLabel: 'ScrollableScaffoldDelegate',
      ));

  ScrollController? _scrollController;

  @override
  void didUpdateWidget(ScrollableScaffoldDelegate oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.scrollController != null && oldWidget.scrollController == null) {
      _scrollController?.dispose();
      _scrollController = null;
    }
  }

  @override
  void dispose() {
    _scrollController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldContentScrollListener(
      builder:
          (
            context,
            maxScrollExtentReached,
            hasScrollExtent,
            didOverscrollBottom,
          ) {
            final overlapsContent = hasScrollExtent && !maxScrollExtentReached;

            // The `footerPinned` parameter tends to be
            // invalid during the first frame due to the `hasScrollExtent`
            // parameter. This issue can occur when the view initially enters
            // the screen or when it is rebuilt with content that exceeds
            // the available space and the previously built content was shorter
            // than the available space.
            //
            // Note: The ScrollableScaffoldDelegate is unlikely to be used for
            // the app's first route. Moreover, subsequent routes are typically
            // shown with a route transition that only partially displays a fraction
            // of the scaffold in the first frame. This ensures that the first
            // frame, where the footer might briefly be in an invalid position, is
            // not noticeable, making this behavior more acceptable.
            final footerPinned = switch (widget.footerBehavior) {
              AppScaffoldFooterBehavior.bottomPinned => true,
              AppScaffoldFooterBehavior.endPinned =>
                hasScrollExtent && !didOverscrollBottom,
              _ => false,
            };

            return PinnedBottomSegmentLayout(
              footerBuilder: footerPinned ? widget.footerBuilder : null,
              overlapsContent: overlapsContent,
              useSafeArea: widget.useSafeArea,
              floatingActionButton: widget.floatingActionButton,
              bodyBuilder: (context, pinnedBottomSegmentHeight) => ScaffoldBody(
                didOverscrollBottom: didOverscrollBottom,
                pinnedBottomSegmentHeight: pinnedBottomSegmentHeight,
                footerBehavior: widget.footerBehavior,
                footerBuilder: footerPinned ? null : widget.footerBuilder,
                scrollController: _effectiveScrollController,
                physics: widget.physics,
                onRefresh: widget.onRefresh,
                sliverContent: SliverScaffoldBodyPadding(
                  hasTopBar: widget.hasTopBar,
                  hasContentFooter:
                      !footerPinned && widget.footerBuilder != null,
                  hasScrollExtent: hasScrollExtent,
                  bottomSegmentHeight: pinnedBottomSegmentHeight,
                  hasPinnedFooter: footerPinned && widget.footerBuilder != null,
                  footerBehavior: widget.footerBehavior,
                  useSafeArea: widget.useSafeArea,
                  useBodyPadding: widget.useBodyPadding,
                  didOverscrollBottom: didOverscrollBottom,
                  sliverBody: widget.sliverContent,
                ),
              ),
            );
          },
    );
  }
}

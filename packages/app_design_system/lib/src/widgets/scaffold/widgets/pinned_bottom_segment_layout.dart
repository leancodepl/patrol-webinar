import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/scaffold/scaffold.dart';
import 'package:boxy/boxy.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const _bodyId = #body;
const _footerId = #footer;
const _floatingActionButtonId = #floatingActionButton;

@internal
typedef PinnedBottomSegmentBodyBuilder =
    Widget Function(
      BuildContext context,
      PinnedBottomSegmentHeight bottomSegmentHeight,
    );

@internal
class PinnedBottomSegmentHeight with EquatableMixin {
  const PinnedBottomSegmentHeight({
    required this.pinnedFooterHeight,
    required this.floatingActionButtonHeight,
  });

  final double? pinnedFooterHeight;
  final double? floatingActionButtonHeight;

  static final floatingActionButtonPadding =
      AppSpacings.s16.horizontal + AppSpacings.s16.bottom;

  double? get paddedFabHeight => switch (floatingActionButtonHeight) {
    final height? => height + floatingActionButtonPadding.vertical,
    null => null,
  };

  double get totalHeight =>
      (pinnedFooterHeight ?? 0) +
      switch (floatingActionButtonHeight) {
        final height? => height + floatingActionButtonPadding.vertical,
        null => 0,
      };

  @override
  List<Object?> get props => [pinnedFooterHeight, floatingActionButtonHeight];
}

@internal
class PinnedBottomSegmentLayout extends StatelessWidget {
  const PinnedBottomSegmentLayout({
    super.key,
    required this.bodyBuilder,
    this.footerBuilder,
    required this.overlapsContent,
    required this.useSafeArea,
    this.floatingActionButton,
  });

  final PinnedBottomSegmentBodyBuilder bodyBuilder;
  final AppScaffoldFooterBuilder? footerBuilder;
  final bool overlapsContent;
  final bool useSafeArea;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.paddingOf(context);

    return CustomBoxy(
      delegate: _PinnedBottomSegmentLayoutDelegate(
        textDirection: Directionality.of(context),
        bodyBuilder: (bottomSegmentHeight) =>
            bodyBuilder(context, bottomSegmentHeight),
        safeAreaPadding: safePadding,
      ),
      children: [
        if (floatingActionButton case final floatingActionButton?)
          BoxyId(
            id: _floatingActionButtonId,
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeLeft: true,
              removeRight: true,
              child: floatingActionButton,
            ),
          ),
        if (footerBuilder case final footerBuilder?)
          BoxyId(
            id: _footerId,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              removeLeft: true,
              removeRight: true,
              child: footerBuilder(
                context,
                overlapsContent,
                safePadding.copyWith(top: 0),
              ),
            ),
          ),
      ],
    );
  }
}

class _PinnedBottomSegmentLayoutDelegate extends BoxyDelegate {
  _PinnedBottomSegmentLayoutDelegate({
    required this.safeAreaPadding,
    required this.textDirection,
    required this.bodyBuilder,
  });

  final EdgeInsets safeAreaPadding;
  final TextDirection textDirection;
  final Widget Function(PinnedBottomSegmentHeight) bodyBuilder;

  BoxyChild get _body => getChild(_bodyId);

  BoxyChild? get _footer => getChildOrNull(_footerId);

  BoxyChild? get _floatingActionButton =>
      getChildOrNull(_floatingActionButtonId);

  @override
  Size layout() {
    if (constraints.hasInfiniteWidth || constraints.hasInfiniteHeight) {
      throw FlutterError.fromParts([
        ErrorSummary('Pinned bottom segment must have fixed constraints'),
        ErrorDescription(
          'The footer builder must have fixed constraints, but the parent'
          'constraints are infinite  (currently - ${[if (constraints.hasInfiniteWidth) 'width', if (constraints.hasInfiniteHeight) 'height'].join(', ')}). Make sure the parent widget has a'
          'bounded size.',
        ),
      ]);
    }

    if (isDryLayout) {
      return constraints.biggest;
    }

    final width = constraints.maxWidth;
    final height = constraints.maxHeight;
    final size = Size(width, height);

    final footerSize = _footer?.layout(
      BoxConstraints(minWidth: width, maxWidth: width, maxHeight: height),
    );

    if (footerSize != null) {
      _footer?.position(
        Alignment.bottomCenter.inscribe(footerSize, Offset.zero & size).topLeft,
      );
    }

    final floatingActionButtonSize = _floatingActionButton?.layout(
      BoxConstraints(maxWidth: width, maxHeight: height),
    );

    if (floatingActionButtonSize != null) {
      var fabAvailableRect = Offset.zero & size;

      fabAvailableRect = switch (_footer) {
        null => safeAreaPadding.deflateRect(fabAvailableRect),
        final footer =>
          safeAreaPadding
              .copyWith(bottom: footer.size.height)
              .deflateRect(fabAvailableRect),
      };

      fabAvailableRect = PinnedBottomSegmentHeight.floatingActionButtonPadding
          .resolve(textDirection)
          .deflateRect(fabAvailableRect);

      _floatingActionButton?.position(
        AlignmentDirectional.bottomEnd
            .resolve(textDirection)
            .inscribe(floatingActionButtonSize, fabAvailableRect)
            .topLeft,
      );
    }

    inflate(
      bodyBuilder(
        PinnedBottomSegmentHeight(
          pinnedFooterHeight: footerSize?.height,
          floatingActionButtonHeight: floatingActionButtonSize?.height,
        ),
      ),
      id: _bodyId,
    );

    _body.layoutWithoutSize(BoxConstraints.tight(size));

    return size;
  }

  @override
  bool shouldRelayout(_PinnedBottomSegmentLayoutDelegate oldDelegate) =>
      safeAreaPadding != oldDelegate.safeAreaPadding ||
      textDirection != oldDelegate.textDirection ||
      bodyBuilder != oldDelegate.bodyBuilder;

  @override
  List<BoxyChild> get children => [_body, ?_footer, ?_floatingActionButton];
}

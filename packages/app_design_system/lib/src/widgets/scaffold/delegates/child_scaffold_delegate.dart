import 'package:app_design_system/src/widgets/scaffold/scaffold.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/scaffold_body_padding.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ChildScaffoldDelegate extends StatelessWidget {
  const ChildScaffoldDelegate({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.footerOnTop = false,
    this.footerBuilder,
    required this.hasTopBar,
    this.useBodyPadding = true,
    this.useSafeArea = true,
  });

  final Widget body;
  final Widget? floatingActionButton;
  final bool footerOnTop;
  final AppChildScaffoldFooterBuilder? footerBuilder;
  final bool hasTopBar;
  final bool useBodyPadding;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return PinnedBottomSegmentLayout(
      overlapsContent: false,
      useSafeArea: useSafeArea,
      bodyBuilder: (context, bottomSegmentHeight) => ChildScaffoldBodyPadding(
        hasTopBar: hasTopBar,
        bottomSegmentHeight: bottomSegmentHeight,
        hasFooter: footerBuilder != null,
        footerOnTop: footerOnTop,
        useSafeArea: useSafeArea,
        useBodyPadding: useBodyPadding,
        body: ClipRect(child: body),
      ),
      floatingActionButton: floatingActionButton,
      footerBuilder: switch (footerBuilder) {
        final footerBuilder? => (context, _, padding) => footerBuilder(
          context,
          padding,
        ),
        null => null,
      },
    );
  }
}

import 'package:app_design_system/src/widgets/scaffold/scaffold.dart';
import 'package:flutter/widgets.dart';

/// A widget that provides a safe area at the bottom of the [AppScaffold].
///
/// This widget should be used as the last child of a scrollable scaffold body
/// if `useSafeArea` flag is false or [AppScaffold] uses a custom scrollable.
/// It's worth noting that a [ListView] with padding set to null (which is the
/// default value) will already use the safe area as the padding, so in this
/// case having [AppScaffoldBottomSafeArea] inside a [ListView] with padding set
/// as `null` will double the bottom safe area.
///
/// See [AppScaffold.bottomSafeAreaOf] which provides the alternative method of
/// retrieving the bottom safe area value to add the padding manually (e.g. in
/// your scrollable's padding). Also see [ListView] for more information about
/// safe area handling.
class AppScaffoldBottomSafeArea extends StatelessWidget {
  const AppScaffoldBottomSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: AppScaffold.bottomSafeAreaOf(context).bottom);
  }
}

/// A sliver widget that provides a safe area at the bottom of the
/// [AppScaffold].
///
/// This sliver widget should be used as the last child of a scrollable scaffold
/// body if `useSafeArea` flag is false or [AppScaffold] uses a custom
/// scrollable.
///
/// See [AppScaffold.bottomSafeAreaOf] which provides the alternative method of
/// retrieving the bottom safe area value to add the padding manually (e.g. in
/// your scrollable's padding).
class SliverAppScaffoldBottomSafeArea extends StatelessWidget {
  const SliverAppScaffoldBottomSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: AppScaffold.bottomSafeAreaOf(context).bottom),
    );
  }
}

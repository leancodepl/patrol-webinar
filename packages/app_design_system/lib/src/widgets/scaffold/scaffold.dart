import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/navigation_bar/navigation_bar.dart';
import 'package:app_design_system/src/widgets/scaffold/delegates/child_scaffold_delegate.dart';
import 'package:app_design_system/src/widgets/scaffold/delegates/scrollable_scaffold_delegate.dart';
import 'package:app_design_system/src/widgets/scaffold/safe_area/scaffold_bottom_safe_area.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/sliver_scaffold_content.dart';
import 'package:app_design_system/src/widgets/top_bar.dart';
import 'package:flutter/material.dart' show Material, RefreshCallback;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

export 'safe_area/scaffold_bottom_safe_area.dart';

/// A function that builds a footer widget for the most of [AppScaffold]
/// constructors:
///
/// `context` provides the build context in which the footer
/// is built.
///
/// `overlapsContent` indicates whether the footer overlaps the content of
/// the scaffold. It can be useful for example when you want the footer to cast
/// a shadow when scrollable has scroll extent and is not currently at the max
/// extent.
///
/// `padding` specifies the padding that should be applied
/// to respect the `SafeArea` of the device.
typedef AppScaffoldFooterBuilder =
    Widget Function(
      BuildContext context,
      bool overlapsContent,
      EdgeInsets padding,
    );

/// A function that builds a footer widget for the [AppScaffold.new]
/// constructor:
///
/// `context` provides the build context in which the footer
/// is built.
///
/// `padding` specifies the padding that should be applied
/// to respect the `SafeArea` of the device.
typedef AppChildScaffoldFooterBuilder =
    Widget Function(BuildContext context, EdgeInsets padding);

/// Different behaviors of the footer in [AppScaffold]. The selected behavior
/// may also affect the position of the floating action button.
///
/// The first word describes the position of the footer when the scaffold's
/// content does not have scroll extent. Typically, it will be positioned at
/// the end of the content or at the bottom of the scaffold.
///
/// The second word describes the behavior of the footer when the content is
/// longer than the scaffold's viewport, resulting in scroll extent. The footer
/// can either be pinned to the bottom of the scaffold and always visible, or it
/// can be pushed by the content, making it visible only when the user scrolls
/// to the end of the contents.
///
/// The footer can have one of the following behaviors:
///
/// [![click here for footer behaviors graphical comparison][comparison]][comparison].
///
/// [comparison]: https://github.com/leancodepl/flutter_tech_summit/blob/master/documentation/features/design_system/scaffold/footer_behaviors.svg?raw=true
enum AppScaffoldFooterBehavior {
  /// The footer will be positioned at the end of the body content if
  /// the content fits in the scaffold. If it does not fit (the content is
  /// scrollable), the footer is pinned to the bottom of the scaffold.
  ///
  /// The footer is always visible on the screen.
  ///
  /// [![click here for footer behaviors graphical comparison][comparison]][comparison].
  ///
  /// [comparison]: https://github.com/leancodepl/flutter_tech_summit/blob/master/documentation/features/design_system/scaffold/footer_behaviors.svg?raw=true
  endPinned,

  /// The footer will be positioned at the bottom of the scaffold if the content
  /// fits in the scaffold. If it does not fit (the content is scrollable),
  /// the footer is pushed by the content to its end.
  ///
  /// This behavior should be used when the footer must be at the bottom of
  /// the screen, but doesn't need to be visible always, but only after the user
  /// scrolled to the end of the content.
  ///
  /// [![click here for footer behaviors graphical comparison][comparison]][comparison].
  ///
  /// [comparison]: https://github.com/leancodepl/flutter_tech_summit/blob/master/documentation/features/design_system/scaffold/footer_behaviors.svg?raw=true
  bottomPushed,

  /// The footer is always pinned (fixed) to the bottom of the scaffold,
  /// regardless of the content length. The footer is always visible on
  /// the screen.
  ///
  /// [![click here for footer behaviors graphical comparison][comparison]][comparison].
  ///
  /// [comparison]: https://github.com/leancodepl/flutter_tech_summit/blob/master/documentation/features/design_system/scaffold/footer_behaviors.svg?raw=true
  bottomPinned,
}

/// A versatile scaffold widget that provides multiple configurations for
/// creating app layouts with consistent structure and behavior. The main
/// purpose of it is to solve common layout problems for mobile apps, such as
/// handling safe areas, body padding, floating action button, dynamically
/// positioned footer and more.
///
/// The [AppScaffold] offers five constructors, each aiming to be used for a
/// specific use case:
///
/// - [AppScaffold.new] is a general-purpose scaffold with optional top bar,
///   body and floating action button. Content is not scrollable. Use only when
///   none of the other constructors fit your needs.
///
/// - [AppScaffold.navigationBar] is a scaffold featuring a bottom navigation
///   bar. Works out of the box with nested navigations from routers like
///   Navigator, GoRouter and others.
///
/// - [AppScaffold.widgets] is a scaffold using box (i.e. non-sliver) widgets
///   for scrollable content. Useful for scrollable views since it already
///   provides handy configuration.
///
/// - [AppScaffold.slivers] is a scaffold using slivers for scrollable content.
///   Useful for more complex scroll behaviors.
///
/// - [AppScaffold.widgetBuilder] is a scaffold for a scrollable list of box
///   (i.e. non-sliver) widgets, oferring a [NullableIndexedWidgetBuilder]
///   function.
///
/// All configurations support additional parameters such as safe area handling,
/// body padding, footer and floating action button inclusion. It's worth to
/// check the documentation of each constructor to understand the differences
/// between them and configure the one you pick accordingly to maximize its
/// potential.
///
/// ## Scaffold with navigation bar
///
/// For the common scenario of having a scaffold with a bottom navigation bar
/// and different contents of the body it's recommended to use two nested [AppScaffold]s.
/// [AppScaffold.navigationBar] outside and other scaffold as its body, so that
/// the pages can have their own footers (e.g. sticky buttons) and the contents
/// of the inner scaffolds are not obstructed by the system keyboard (thanks
/// to [resizeToAvoidBottomInset] in the inner scaffold).
///
/// [![Nested scaffolds screenshot][nested-scaffolds]][nested-scaffolds]
class AppScaffold extends StatelessWidget {
  /// Creates a general-purpose scaffold with non-scrollable body. Use this
  /// constructor when your layout requires a simple top bar, non-scrollable
  /// body, and optionally a floating action button. This configuration is ideal
  /// for static content that doesn't require scrolling behavior.
  ///
  /// If the content is not a very small widget, consider wrapping body in
  /// [SingleChildScrollView] to make sure content won't overflow on very
  /// small screens.
  ///
  /// `topBar` is [AppTopBar] component displayed at the top of the scaffold.
  ///
  /// `body` is the main [Widget] content of the scaffold.
  ///
  /// `floatingActionButton` is optional [Widget] displayed on the body aligned
  /// to bottom end corner of the view.
  ///
  /// The `footerOnTop` flag determines the position of the footer. When set to
  /// `true`, the footer is displayed above the body content, allowing the body
  /// to extend beneath it. When set to `false`, the footer is positioned below
  /// the body. This flag is particularly useful for [AppScaffold]s with footer
  /// that has some transparency and a scrollable body, enabling content to
  /// remain visible underneath the footer.
  ///
  /// `footerBuilder` is a builder for a footer widget.
  ///
  /// See [AppScaffoldFooterBuilder].
  ///
  /// `useBodyPadding` is adds padding to the body if set to `true`. Default
  /// padding value can be found and configured in [AppScaffold.bodyPadding].
  ///
  /// `useSafeArea` ensures content respects safe area constraints. By setting
  /// it to `false` or creating your own scrollable widget inside `body`, you
  /// have to handle bottom safe area by yourself.
  ///
  /// `resizeToAvoidBottomInset` determines whether the bottom edge of
  /// the scaffold should move up with the bottom inset (e.g. system keyboard).
  /// Defaults to true.
  ///
  /// See [AppScaffoldBottomSafeArea], [SliverAppScaffoldBottomSafeArea] widgets
  /// and method [AppScaffold.bottomSafeAreaOf].
  AppScaffold({
    super.key,
    this.topBar,
    required Widget body,
    Widget? floatingActionButton,
    bool footerOnTop = false,
    AppChildScaffoldFooterBuilder? footerBuilder,
    bool useBodyPadding = true,
    bool useSafeArea = true,
    this.resizeToAvoidBottomInset = true,
  }) : delegate = ChildScaffoldDelegate(
         hasTopBar: topBar != null,
         body: body,
         footerOnTop: footerOnTop,
         footerBuilder: footerBuilder,
         floatingActionButton: floatingActionButton,
         useBodyPadding: useBodyPadding,
         useSafeArea: useSafeArea,
       );

  /// A scaffold featuring a bottom navigation bar. Works out of the box with
  /// nested navigations from routers like Navigator, GoRouter and others.
  /// Useful for views with nested routes or tab bar like navigation.
  ///
  /// For the common scenario of having a scaffold with a bottom navigation bar
  /// and different contents of the body it's recommended to use two nested [AppScaffold]s.
  /// [AppScaffold.navigationBar] outside and other scaffold as its body, so that
  /// the pages can have their own footers (e.g. sticky buttons) and the contents
  /// of the inner scaffolds are not obstructed by the system keyboard (thanks
  /// to [resizeToAvoidBottomInset] in the inner scaffold).
  ///
  /// [![Nested scaffolds screenshot][nested-scaffolds]][nested-scaffolds]
  ///
  /// `topBar` is a [AppTopBar] component displayed at the top of the scaffold.
  ///
  /// `body` is an acquired [Widget] page content from the router (Navigator,
  /// GoRouter, etc.).
  ///
  /// `navigationController` manages the state of the navigation bar. Take a
  /// look at [AppNavigationBarController] documentation for more details.
  ///
  /// `navigationItems` are [AppNavigationBarItem]s representing possible
  /// routes within the view. Also used to display available routes in
  /// the navigation bar.
  ///
  /// `floatingActionButton` is an optional [Widget] displayed on the body
  /// aligned to bottom end corner of the view.
  ///
  /// `useSafeArea` ensures content respects safe area constraints. By setting
  /// it to `false`, you have to handle bottom safe area by yourself.
  ///
  /// `resizeToAvoidBottomInset` determines whether the bottom edge of
  /// the scaffold should move up with the bottom inset (e.g. system keyboard).
  /// Defaults to false for this constructor to avoid the bottom navigation bar
  /// being pushed up when keyboard is shown.
  ///
  /// See [AppScaffoldBottomSafeArea], [SliverAppScaffoldBottomSafeArea] widgets
  /// and method [AppScaffold.bottomSafeAreaOf].
  ///
  /// [nested-scaffolds]: https://github.com/leancodepl/flutter_tech_summit/blob/master/documentation/features/design_system/scaffold/nested_scaffolds.png?raw=true
  AppScaffold.navigationBar({
    super.key,
    this.topBar,
    required AppNavigationBarController navigationController,
    required Widget body,
    required List<AppNavigationBarItem> navigationItems,
    GlobalKey? navigationBarKey,
    Widget? floatingActionButton,
    bool useSafeArea = true,
    this.resizeToAvoidBottomInset = false,
  }) : delegate = ChildScaffoldDelegate(
         hasTopBar: topBar != null,
         body: body,
         floatingActionButton: floatingActionButton,
         footerBuilder: (context, padding) => Padding(
           padding: padding,
           child: AppNavigationBar(
             key: navigationBarKey,
             controller: navigationController,
             items: navigationItems,
           ),
         ),
         useSafeArea: useSafeArea,
         useBodyPadding: false,
       );

  /// Creates a scaffold with a scrollable list of box (i.e. non-sliver) widgets
  /// as the main content.
  ///
  /// `children` are the list of box (i.e. non-sliver) [Widget]s to display as
  /// the primary content.
  ///
  /// `topBar` is an [AppTopBar] component displayed at the top of the scaffold.
  ///
  /// `floatingActionButton` is an optional [Widget] displayed on the body
  /// aligned to bottom end corner of the view.
  ///
  /// `useSafeArea` ensures content respects safe area constraints. By setting
  /// it to `false`, you have to handle bottom safe area by yourself.
  ///
  /// See [AppScaffoldBottomSafeArea], [SliverAppScaffoldBottomSafeArea] widgets
  /// and method [AppScaffold.bottomSafeAreaOf].
  ///
  /// `useBodyPadding` adds padding to the body if set to `true`. Default
  /// padding value can be found and configured in [AppScaffold.bodyPadding].
  ///
  /// `scrollController` is a [ScrollController] for the scrollable content.
  ///
  /// `physics` defines the scroll physics for the list.
  ///
  /// `itemExtent`, `itemExtentBuilder`, `prototypeItem` are advanced options
  /// for optimizing list rendering.
  ///
  /// `resizeToAvoidBottomInset` determines whether the bottom edge of
  /// the scaffold should move up with the bottom inset (e.g. system keyboard).
  /// Defaults to true.
  ///
  /// `footerBehavior` defines footer display behavior.
  ///
  /// See [AppScaffoldFooterBehavior].
  ///
  /// `footerBuilder` is a builder for a footer widget.
  ///
  /// See [AppScaffoldFooterBuilder].
  AppScaffold.widgets({
    super.key,
    this.topBar,
    required List<Widget> children,
    Widget? floatingActionButton,
    bool useBodyPadding = true,
    bool useSafeArea = true,
    this.resizeToAvoidBottomInset = true,
    AppScaffoldFooterBehavior footerBehavior =
        AppScaffoldFooterBehavior.endPinned,
    AppScaffoldFooterBuilder? footerBuilder,
    ScrollController? scrollController,
    ScrollPhysics? physics,
    double? itemExtent,
    ItemExtentBuilder? itemExtentBuilder,
    Widget? prototypeItem,
    RefreshCallback? onRefresh,
  }) : assert(
         [itemExtent, itemExtentBuilder, prototypeItem].nonNulls.length <= 1,
         'At most one of the itemExtent, itemExtentBuilder or prototypeItem parameters must be non-null',
       ),
       delegate = ScrollableScaffoldDelegate(
         hasTopBar: topBar != null,
         scrollController: scrollController,
         physics: physics,
         floatingActionButton: floatingActionButton,
         footerBehavior: footerBehavior,
         footerBuilder: footerBuilder,
         useSafeArea: useSafeArea,
         useBodyPadding: useBodyPadding,
         onRefresh: onRefresh,
         sliverContent: SliverScaffoldContent(
           itemExtent: itemExtent,
           itemExtentBuilder: itemExtentBuilder,
           prototypeItem: prototypeItem,
           children: children,
         ),
       );

  /// Creates a scaffold with a scrollable list of sliver widgets as the main
  /// content.
  ///
  /// `slivers` are list of slivers to display as the primary scrollable
  /// content.
  ///
  /// `topBar` is an [AppTopBar] component displayed at the top of the scaffold.
  ///
  /// `floatingActionButton` is an optional [Widget] displayed on the body
  /// aligned to bottom end corner of the view.
  ///
  /// `useSafeArea` ensures content respects safe area constraints. By setting
  /// it to `false`, you have to handle bottom safe area by yourself.
  ///
  /// See [AppScaffoldBottomSafeArea], [SliverAppScaffoldBottomSafeArea] widgets
  /// and method [AppScaffold.bottomSafeAreaOf].
  ///
  /// `useBodyPadding` adds padding to the body if set to `true`. Default
  /// padding value can be found and configured in `AppScaffold.bodyPadding`.
  ///
  /// `resizeToAvoidBottomInset` determines whether the bottom edge of
  /// the scaffold should move up with the bottom inset (e.g. system keyboard).
  /// Defaults to true.
  ///
  /// `footerBehavior` defines footer display behavior.
  ///
  /// See [AppScaffoldFooterBehavior].
  ///
  /// `footerBuilder` is a builder for a footer widget.
  ///
  /// See [AppScaffoldFooterBuilder].
  ///
  /// `scrollController` is a [ScrollController] for the scrollable content.
  ///
  /// `physics` defines the scroll physics for the list.
  AppScaffold.slivers({
    super.key,
    this.topBar,
    required List<Widget> slivers,
    Widget? floatingActionButton,
    bool useBodyPadding = true,
    bool useSafeArea = true,
    this.resizeToAvoidBottomInset = true,
    AppScaffoldFooterBehavior footerBehavior =
        AppScaffoldFooterBehavior.endPinned,
    AppScaffoldFooterBuilder? footerBuilder,
    ScrollController? scrollController,
    ScrollPhysics? physics,
  }) : delegate = ScrollableScaffoldDelegate(
         hasTopBar: topBar != null,
         scrollController: scrollController,
         physics: physics,
         floatingActionButton: floatingActionButton,
         footerBehavior: footerBehavior,
         footerBuilder: footerBuilder,
         useSafeArea: useSafeArea,
         useBodyPadding: useBodyPadding,
         sliverContent: SliverMainAxisGroup(slivers: slivers),
       );

  /// Creates a scaffold with scrollable, linear list of box (i.e. non-sliver)
  /// widgets with [NullableIndexedWidgetBuilder] function and optional
  /// `itemCount` parameter. This constructor is appropriate for list views with
  /// large or infinite number of items because the `builder` method is only
  /// called for the items that are currently visible on the screen.
  ///
  /// `itemCount` is a total number of items in the list. Providing non-null
  /// value improves the ability of [AppScaffold.widgetBuilder] to estimate the
  /// maximum scroll extent.
  ///
  /// `builder` is a [NullableIndexedWidgetBuilder] function to build each item
  /// based on its index. This will be called only for the indices greater than
  /// or equal to zero and less than `itemCount`. If this returns null, the
  /// scroll view will stop calling the builder even if `itemCount` suggests
  /// that there are more items.
  ///
  /// `separatorBuilder` is an optional [NullableIndexedWidgetBuilder] function
  /// to build a separator widget between items.
  ///
  /// `topBar` is an [AppTopBar] component displayed at the top of the scaffold.
  ///
  /// `resizeToAvoidBottomInset` determines whether the bottom edge of
  /// the scaffold should move up with the bottom inset (e.g. system keyboard).
  /// Defaults to true.
  ///
  /// `footerBehavior` defines footer display behavior.
  ///
  /// See [AppScaffoldFooterBehavior].
  ///
  /// `footerBuilder` is a builder for a footer widget.
  ///
  /// See [AppScaffoldFooterBuilder].
  ///
  /// `floatingActionButton` is an optional [Widget] displayed on the body
  /// aligned to bottom end corner of the view.
  ///
  /// `useSafeArea` ensures content respects safe area constraints. By setting
  /// it to `false`, you have to handle bottom safe area by yourself.
  ///
  /// See [AppScaffoldBottomSafeArea], [SliverAppScaffoldBottomSafeArea] widgets
  /// and method [AppScaffold.bottomSafeAreaOf].
  ///
  /// `useBodyPadding` adds padding to the body if set to `true`. Default
  /// padding value can be found and configured in [AppScaffold.bodyPadding].
  ///
  /// `scrollController` is an [ScrollController] for the scrollable content.
  ///
  /// `physics` defines the scroll physics for the list.
  ///
  /// `itemExtent`, `itemExtentBuilder`, `prototypeItem` are advanced options
  /// for optimizing list rendering.
  AppScaffold.widgetBuilder({
    super.key,
    this.topBar,
    int? itemCount,
    required NullableIndexedWidgetBuilder builder,
    IndexedWidgetBuilder? separatorBuilder,
    AppScaffoldFooterBehavior footerBehavior =
        AppScaffoldFooterBehavior.endPinned,
    AppScaffoldFooterBuilder? footerBuilder,
    Widget? floatingActionButton,
    bool useBodyPadding = true,
    bool useSafeArea = true,
    this.resizeToAvoidBottomInset = true,
    ScrollController? scrollController,
    ScrollPhysics? physics,
    double? itemExtent,
    ItemExtentBuilder? itemExtentBuilder,
    Widget? prototypeItem,
  }) : assert(
         [
               itemExtent,
               itemExtentBuilder,
               prototypeItem,
               separatorBuilder,
             ].nonNulls.length <=
             1,
         'At most one of the itemExtent, itemExtentBuilder, prototypeItem or separatorBuilder parameters must be non-null',
       ),
       delegate = ScrollableScaffoldDelegate(
         hasTopBar: topBar != null,
         scrollController: scrollController,
         physics: physics,
         floatingActionButton: floatingActionButton,
         footerBehavior: footerBehavior,
         footerBuilder: footerBuilder,
         useSafeArea: useSafeArea,
         useBodyPadding: useBodyPadding,
         sliverContent: separatorBuilder != null
             ? SliverScaffoldContent.separated(
                 itemCount: itemCount,
                 builder: builder,
                 separatorBuilder: separatorBuilder,
               )
             : SliverScaffoldContent.builder(
                 itemExtent: itemExtent,
                 itemExtentBuilder: itemExtentBuilder,
                 prototypeItem: prototypeItem,
                 itemCount: itemCount,
                 builder: builder,
               ),
       );

  final Widget? topBar;
  final Widget delegate;
  final bool resizeToAvoidBottomInset;

  static const bodyPadding = AppSpacings.content;

  /// Method that provides the bottom safe area value of the [AppScaffold].
  ///
  /// This method can be used to get [AppScaffold] bottom safe area size in
  /// order to add it manually as padding to the end of scrollable
  /// [AppScaffold]'s body when `useSafeArea` flag is false or [AppScaffold]
  /// uses a custom scrollable.
  ///
  /// It's worth noting that a [ListView] with padding set to null (which is
  /// the default value) will already use the safe area as the padding, so in
  /// this case having [AppScaffoldBottomSafeArea] inside a [ListView] with
  /// padding set as `null` will double the bottom safe area.
  ///
  /// See [AppScaffoldBottomSafeArea] which provides the alternative method of
  /// handling the bottom safe area. Also see [ListView] for more information
  /// about the safe area handling.
  static EdgeInsetsDirectional bottomSafeAreaOf(BuildContext context) {
    return EdgeInsetsDirectional.only(
      bottom: MediaQuery.paddingOf(context).bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final mediaQuery = MediaQuery.of(context);

    final body = Padding(
      padding: EdgeInsets.only(
        bottom: resizeToAvoidBottomInset ? mediaQuery.viewInsets.bottom : 0,
      ),
      child: MediaQuery(
        data: mediaQuery
            .removePadding(removeTop: topBar != null)
            .removeViewInsets(removeBottom: resizeToAvoidBottomInset),
        child: delegate,
      ),
    );

    final Widget child;
    if (topBar case final topBar?) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topBar,
          Expanded(child: body),
        ],
      );
    } else {
      child = body;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: switch (colors.brightness) {
        Brightness.light => SystemUiOverlayStyle.dark,
        Brightness.dark => SystemUiOverlayStyle.light,
      },
      child: Material(
        color: colors.backgroundDefaultPrimary,
        child: ScrollNotificationObserver(child: child),
      ),
    );
  }
}

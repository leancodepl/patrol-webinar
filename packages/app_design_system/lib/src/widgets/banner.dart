import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/styleguide.dart';
import 'package:app_design_system/src/widgets/button/button.dart';
import 'package:app_design_system/src/widgets/button/text_button.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';

enum AppBannerType {
  info,
  success,
  warning,
  danger;

  AppColor? _getColor(AppColors colors) => switch (this) {
    info => colors.foregroundInfoSecondary,
    success => colors.foregroundSuccessSecondary,
    warning => colors.foregroundWarningSecondary,
    danger => colors.foregroundDangerSecondary,
  };
}

/// If and how should the banner be closable.
///
/// See:
/// - [AppBannerCloseStrategy.none]
/// - [AppBannerCloseStrategy.collapsible]
/// - [AppBannerCloseStrategy.delegated]
sealed class AppBannerCloseStrategy {
  const AppBannerCloseStrategy();

  /// The banner can be closed by tapping the close icon button, it will animate
  /// the banner reducing height and opacity to 0, and then call [onClosed].
  ///
  /// The [onClosed] callback is called after the animation is completed, it can
  /// be used to remove the banner from the widget tree or persist the close state.
  ///
  /// The [padding] is used to add an outer margin to the whole banner that will
  /// be part of the collapse animation as well.
  const factory AppBannerCloseStrategy.collapsible({
    VoidCallback? onClosed,
    EdgeInsetsGeometry? padding,
  }) = _CollapsibleCloseStrategy;

  /// The banner has the close icon button, tapping it will call [onCloseTap].
  /// There is no additional behavior, hiding the banner is the responsibility
  /// of the parent widget.
  const factory AppBannerCloseStrategy.delegated({
    required VoidCallback onCloseTap,
  }) = _DelegatedCloseStrategy;

  /// The banner does not have the close icon button and cannot be closed.
  static const none = _NoCloseStrategy();

  /// Wraps the banner with the close behavior and passes the close callback
  /// to be used in the close icon button that should be part of the banner if not null.
  Widget _wrapper(Widget Function(VoidCallback? onCloseTap) bannerBuilder);
}

/// A banner component is a user interface element that displays
/// a prominent message and related optional actions.
/// It is often used to communicate important information to the user
/// and may require a user action to be dismissed.
///
/// The banner has two layouts: bar and box. If the [description] is not null,
/// the box layout will be used, otherwise the bar layout will be used. You can
/// force the box layout by setting [forceBoxLayout] to true.
/// The bar layout displays icon, title, actions, and close icon button in a row.
/// The box layout displays title, description and actions in a column.
class AppBanner extends StatelessWidget {
  /// [actions] should be [AppRawButton]s with size large.
  const AppBanner({
    super.key,
    required this.type,
    this.forceBoxLayout = false,
    required this.title,
    this.icon,
    this.description,
    this.closeStrategy = const AppBannerCloseStrategy.collapsible(),
    this.actions = const [],
  });

  final AppBannerType type;

  /// If true, the banner will use the box layout even if the [description] is null.
  final bool forceBoxLayout;
  final AppStandardIconData? icon;
  final String title;
  final String? description;
  final AppBannerCloseStrategy closeStrategy;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return closeStrategy._wrapper(
      (onCloseTap) => _Banner(
        type: type,
        forceBoxLayout: forceBoxLayout,
        icon: icon,
        title: title,
        description: description,
        closeIconButton: onCloseTap != null
            ? _CloseButton(onCloseTap: onCloseTap)
            : null,
        actions: actions,
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    required this.type,
    required this.forceBoxLayout,
    required this.icon,
    required this.title,
    required this.description,
    required this.closeIconButton,
    required this.actions,
  });

  final AppBannerType type;
  final bool forceBoxLayout;
  final AppStandardIconData? icon;
  final String title;
  final String? description;
  final Widget? closeIconButton;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final indicatorColor = type._getColor(colors);

    final titleWidget = AppText(
      title,
      style: AppTextStyles.headlineSmall,
      color: colors.foregroundDefaultPrimary,
    );
    final descriptionWidget = switch (description) {
      final description? => AppText(
        description,
        style: AppTextStyles.bodyDefault,
        color: colors.foregroundDefaultSecondary,
      ),
      _ => null,
    };

    final actionsWidget = switch (actions.isNotEmpty) {
      true => Row(spacing: AppSpacings.s8.value, children: actions),
      false => null,
    };

    final iconWidget = switch (icon) {
      final icon? => AppIcon(
        icon,
        size: AppStandardIconSize.s24,
        color: colors.foregroundDefaultSecondary,
        semanticsLabel: null,
      ),
      _ => null,
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colors.backgroundDefaultPrimary,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.passthrough,
        children: [
          Padding(
            padding: AppSpacings.s16.vertical,
            child: switch (description != null || forceBoxLayout) {
              true => _BoxLayout(
                icon: iconWidget,
                title: titleWidget,
                description: descriptionWidget,
                actions: actionsWidget,
                closeIconButton: closeIconButton,
              ),
              false => _BarLayout(
                icon: iconWidget,
                title: titleWidget,
                actions: actionsWidget,
                closeIconButton: closeIconButton,
              ),
            },
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
    );
  }
}

class _BarLayout extends StatelessWidget {
  const _BarLayout({
    required this.icon,
    required this.title,
    required this.actions,
    required this.closeIconButton,
  });

  final Widget? icon;
  final Widget title;
  final Widget? actions;
  final Widget? closeIconButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSpacings.s16.horizontalSpace,
        if (icon case final icon?) ...[icon, AppSpacings.s16.horizontalSpace],
        Expanded(child: title),
        if (actions case final actions?) ...[
          AppSpacings.s16.horizontalSpace,
          actions,
        ],
        if (closeIconButton case final closeIconButton?) ...[
          AppSpacings.s16.horizontalSpace,
          closeIconButton,
        ],
        AppSpacings.s16.horizontalSpace,
      ],
    );
  }
}

class _BoxLayout extends StatelessWidget {
  const _BoxLayout({
    required this.icon,
    required this.title,
    required this.description,
    required this.actions,
    required this.closeIconButton,
  });

  final Widget? icon;
  final Widget title;
  final Widget? description;
  final Widget? actions;
  final Widget? closeIconButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacings.s16.horizontalSpace,
        if (icon case final icon?) ...[icon, AppSpacings.s16.horizontalSpace],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              title,
              if (description case final description?) ...[
                AppSpacings.s8.verticalSpace,
                description,
              ],
              if (actions case final actions?) ...[
                AppSpacings.s16.verticalSpace,
                actions,
              ],
            ],
          ),
        ),
        if (closeIconButton case final closeIconButton?) ...[
          AppSpacings.s16.horizontalSpace,
          closeIconButton,
        ],
        AppSpacings.s16.horizontalSpace,
      ],
    );
  }
}

final class _NoCloseStrategy extends AppBannerCloseStrategy {
  const _NoCloseStrategy();

  @override
  Widget _wrapper(Widget Function(VoidCallback? onCloseTap) bannerBuilder) {
    return bannerBuilder(null);
  }

  @override
  String toString() => 'AppBannerCloseStrategy.none';
}

final class _CollapsibleCloseStrategy extends AppBannerCloseStrategy {
  const _CollapsibleCloseStrategy({this.onClosed, this.padding});

  final VoidCallback? onClosed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget _wrapper(Widget Function(VoidCallback? onCloseTap) bannerBuilder) {
    return _BannerCollapser(
      bannerBuilder: (onCloseTap) {
        final banner = bannerBuilder(onCloseTap);

        return switch (padding) {
          final padding? => Padding(padding: padding, child: banner),
          _ => banner,
        };
      },
      onClosed: onClosed,
    );
  }

  @override
  String toString() =>
      'AppBannerCloseStrategy.collapsible(onClosed: $onClosed, padding: $padding)';
}

final class _DelegatedCloseStrategy extends AppBannerCloseStrategy {
  const _DelegatedCloseStrategy({required this.onCloseTap});

  final VoidCallback onCloseTap;

  @override
  Widget _wrapper(Widget Function(VoidCallback? onCloseTap) bannerBuilder) {
    return bannerBuilder(onCloseTap);
  }

  @override
  String toString() =>
      'AppBannerCloseStrategy.delegated(onCloseTap: $onCloseTap)';
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.color});

  final AppColor color;

  @override
  Widget build(BuildContext context) {
    return Container(color: color, width: 8);
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
      semanticsLabel: context.l10n.banner_close,
    );
  }
}

class _BannerCollapser extends StatefulWidget {
  const _BannerCollapser({required this.bannerBuilder, required this.onClosed});

  final Widget Function(VoidCallback onCloseTap) bannerBuilder;
  final VoidCallback? onClosed;

  @override
  State<_BannerCollapser> createState() => _BannerCollapserState();
}

class _BannerCollapserState extends State<_BannerCollapser>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _collapse() {
    final tickerFuture = _controller.forward();
    if (widget.onClosed case final onClosed?) {
      tickerFuture.whenComplete(onClosed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => switch (_controller.isCompleted) {
        true => const SizedBox(),
        false => IgnorePointer(
          ignoring: _controller.isForwardOrCompleted,
          child: child,
        ),
      },
      child: FadeTransition(
        opacity: _animation,
        child: SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1,
          child: widget.bannerBuilder(_collapse),
        ),
      ),
    );
  }
}

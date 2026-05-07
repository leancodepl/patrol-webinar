import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:flutter/widgets.dart';

class AppPaginationDots extends StatelessWidget {
  const AppPaginationDots({
    super.key,
    required int this.current,
    required this.pages,
  }) : assert(pages > 0, 'pages must be greater than 0');

  const AppPaginationDots._({required this.current, required this.pages})
    : assert(pages > 0, 'pages must be greater than 0');

  static Widget pageController({
    Key? key,
    required PageController controller,
    required int pages,
  }) {
    return _PageControllerPaginationDots(
      key: key,
      controller: controller,
      pages: pages,
    );
  }

  final int? current;
  final int pages;

  static const _entryDuration = Duration(milliseconds: 50);
  static const _leaveDuration = Duration(milliseconds: 250);
  static const _curve = Curves.ease;
  static const _size = Size.square(12);

  int? get _effectiveCurrent => current?.clamp(0, pages - 1);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < pages; index++) ...[
          if (index > 0) AppSpacings.s4.horizontalSpace,
          _Dot(selected: index == _effectiveCurrent),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedContainer(
      duration: switch (selected) {
        true => AppPaginationDots._entryDuration,
        false => AppPaginationDots._leaveDuration,
      },
      curve: AppPaginationDots._curve,
      width: AppPaginationDots._size.width,
      height: AppPaginationDots._size.height,
      decoration: BoxDecoration(
        color: switch (selected) {
          true => colors.foregroundDefaultPrimary,
          false => colors.foregroundDefaultQuaternary,
        },
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PageControllerPaginationDots extends StatelessWidget {
  const _PageControllerPaginationDots({
    required super.key,
    required this.controller,
    required this.pages,
  });

  final PageController controller;
  final int pages;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return AppPaginationDots._(
          current: controller.page?.round(),
          pages: pages,
        );
      },
    );
  }
}

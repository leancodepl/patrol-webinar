part of 'snackbar.dart';

class _SnackbarSwitcher extends StatelessWidget {
  const _SnackbarSwitcher();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s16.all,
      child: const Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: _Switcher(),
      ),
    );
  }
}

class _Switcher extends StatelessWidget {
  const _Switcher();

  @override
  Widget build(BuildContext context) {
    final messenger = AppSnackbarTheater.messengerOf(context);

    return ListenableBuilder(
      listenable: messenger,
      builder: (context, _) {
        final entry = messenger.firstEntryOrNull;

        return PageTransitionSwitcher(
          reverse: true,
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return _Transition(
              primaryAnimation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          layoutBuilder: (entries) =>
              Stack(alignment: Alignment.bottomCenter, children: entries),
          child: switch (entry) {
            final entry? => KeyedSubtree(
              key: ValueKey(entry),
              child: _Snackbar(entry: entry),
            ),
            null => const SizedBox(),
          },
        );
      },
    );
  }
}

class _Transition extends StatelessWidget {
  const _Transition({
    required this.primaryAnimation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> primaryAnimation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _EnterTransition(
        animation: secondaryAnimation,
        child: _LeaveTransition(animation: primaryAnimation, child: child),
      ),
    );
  }
}

class _EnterTransition extends StatelessWidget {
  const _EnterTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0, 1),
      ).animate(curvedAnimation),
      child: FadeTransition(
        opacity: Tween<double>(begin: 1, end: 0).animate(curvedAnimation),
        child: child,
      ),
    );
  }
}

class _LeaveTransition extends StatelessWidget {
  const _LeaveTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(curvedAnimation),
        child: child,
      ),
    );
  }
}

class _Snackbar extends StatelessWidget {
  const _Snackbar({required this.entry});

  final SnackbarEntry entry;

  @override
  Widget build(BuildContext context) {
    final messenger = AppSnackbarTheater.messengerOf(context);

    // TODO(jtarkowski27): Add swipe to dismiss
    return ListenableBuilder(
      listenable: messenger,
      builder: (context, _) => IgnorePointer(
        ignoring: messenger.firstEntryOrNull != entry,
        child: GestureDetector(
          onVerticalDragStart: (_) => entry.pause(),
          onVerticalDragEnd: (_) => entry.resume(),
          onVerticalDragCancel: entry.resume,
          onHorizontalDragStart: (_) => entry.pause(),
          onHorizontalDragEnd: (_) => entry.resume(),
          onHorizontalDragCancel: entry.resume,
          onTapDown: (_) => entry.pause(),
          onTapUp: (_) => entry.resume(),
          onTapCancel: entry.resume,
          child: entry.snackbar,
        ),
      ),
    );
  }
}

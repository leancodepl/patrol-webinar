import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_app.dart';

void main() {
  group('AppCore', () {
    testWidgets(
      'wraps child widget tree with a single global builder if provided',
      (tester) async {
        _TestGlobalWrapperState? firstGlobalWrapper;
        _TestGlobalWrapperState? secondGlobalWrapper;

        final secondPageRoute = MaterialPageRoute<void>(
          builder: (context) {
            secondGlobalWrapper = _TestGlobalWrapper.maybeOf(context);
            return const SizedBox.shrink();
          },
        );

        await tester.pumpWidgetBuilder(
          TestApp(
            child: Builder(
              builder: (context) => AppCore(
                colors: context.colors,
                builder: (context, child) => _TestGlobalWrapper(child: child),
                pageBuilder: (context, child) => _TestPageWrapper(child: child),
                home: Builder(
                  builder: (context) {
                    firstGlobalWrapper = _TestGlobalWrapper.maybeOf(context);
                    return AppRawButton(
                      caption: 'Push',
                      size: AppButtonSize.medium,
                      type: AppButtonType.primary,
                      onTap: () => Navigator.of(context).push(secondPageRoute),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.text('Push'));
        await tester.pumpAndSettle();

        expect(firstGlobalWrapper, isNotNull);
        expect(secondGlobalWrapper, isNotNull);
        expect(firstGlobalWrapper, equals(secondGlobalWrapper));
      },
    );

    testWidgets('wraps each page individually with a pageBuilder if provided', (
      tester,
    ) async {
      var descendantsCount = 0;

      _TestPageWrapperState? firstPageWrapper;
      _TestPageWrapperState? secondPageWrapper;

      final secondPageRoute = MaterialPageRoute<void>(
        builder: (context) {
          secondPageWrapper = _TestPageWrapper.maybeOf(context);
          return const SizedBox.shrink();
        },
      );

      await tester.pumpWidgetBuilder(
        TestApp(
          child: AppCore(
            colors: AppColorThemes.light,
            builder: (context, child) => _TestGlobalWrapper(
              onDescendantsChanged: (descendants) =>
                  descendantsCount = descendants.length,
              child: child,
            ),
            pageBuilder: (context, child) => _TestPageWrapper(child: child),
            home: Builder(
              builder: (context) {
                firstPageWrapper = _TestPageWrapper.maybeOf(context);
                return AppRawButton(
                  caption: 'Push',
                  size: AppButtonSize.medium,
                  type: AppButtonType.primary,
                  onTap: () => Navigator.of(context).push(secondPageRoute),
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The home page is wrapped by the global wrapper and the page wrapper.
      // In total, there is only one `_TestPageWrapper` registered.
      expect(descendantsCount, 1);

      await tester.tap(find.text('Push'));
      await tester.pumpAndSettle();

      // When we push a new page, the new page is wrapped by the global wrapper
      // and the new individual page wrapper. In total, there is two
      // `_TestPageWrapper` widgets registered.
      expect(descendantsCount, 2);

      // The first page wrapper is not the same as the second page wrapper.
      expect(firstPageWrapper, isNotNull);
      expect(secondPageWrapper, isNotNull);
      expect(firstPageWrapper, isNot(equals(secondPageWrapper)));
    });
  });
}

class _TestGlobalWrapper extends StatefulWidget {
  const _TestGlobalWrapper({required this.child, this.onDescendantsChanged});

  final Widget? child;
  final ValueChanged<Set<GlobalKey>>? onDescendantsChanged;

  static _TestGlobalWrapperState? maybeOf(BuildContext context) =>
      _TestWrapperScope.maybeOf<_TestGlobalWrapperState>(context)?.wrapper;

  @override
  State<_TestGlobalWrapper> createState() => _TestGlobalWrapperState();
}

class _TestGlobalWrapperState extends State<_TestGlobalWrapper> {
  final _descendants = <GlobalKey>{};

  void addDescendant(GlobalKey key) {
    _descendants.add(key);
    widget.onDescendantsChanged?.call(_descendants);
  }

  void removeDescendant(GlobalKey key) {
    _descendants.remove(key);
    widget.onDescendantsChanged?.call(_descendants);
  }

  @override
  Widget build(BuildContext context) {
    return _TestWrapperScope(
      wrapper: this,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }
}

class _TestWrapperScope<T> extends InheritedWidget {
  const _TestWrapperScope({required super.child, required this.wrapper});

  final T wrapper;

  static _TestWrapperScope<T>? maybeOf<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TestWrapperScope<T>>();

  @override
  bool updateShouldNotify(_TestWrapperScope<T> oldWidget) =>
      oldWidget.wrapper != wrapper;
}

class _TestPageWrapper extends StatefulWidget {
  const _TestPageWrapper({required this.child});

  final Widget? child;

  static _TestPageWrapperState? maybeOf(BuildContext context) =>
      _TestWrapperScope.maybeOf<_TestPageWrapperState>(context)?.wrapper;

  @override
  State<_TestPageWrapper> createState() => _TestPageWrapperState();
}

class _TestPageWrapperState extends State<_TestPageWrapper> {
  final key = GlobalKey();

  _TestGlobalWrapperState? _scope;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = _TestGlobalWrapper.maybeOf(context);

    if (_scope != scope) {
      _scope?.removeDescendant(key);
      _scope = scope;
      _scope?.addDescendant(key);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scope?.removeDescendant(key);
  }

  @override
  Widget build(BuildContext context) {
    return _TestWrapperScope(
      wrapper: this,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }
}

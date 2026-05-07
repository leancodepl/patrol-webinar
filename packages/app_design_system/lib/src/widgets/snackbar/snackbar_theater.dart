import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/widgets/snackbar/snackbar_messenger.dart';
import 'package:flutter/widgets.dart';

/// A widget that provides a [SnackbarMessenger] to its descendants.
///
/// This widget should be added as high as possible in the widget tree, ideally
/// at the root, to allow pushing snackbars from anywhere in the widget tree.
///
/// [AppSnackbarTheater] does not display anything by itself but rather provides
/// an interface which is then used to display snackbars through [AppSnackbarScene].
///
/// See also:
/// * [AppSnackbarScene] for the interface to display snackbars.
/// * [AppSnackbar] for a single snackbar widget.
/// * [SnackbarMessenger] for the class responsible for managing the snackbar queue.
class AppSnackbarTheater extends StatefulWidget {
  const AppSnackbarTheater({super.key, required this.child});

  final Widget child;

  static SnackbarMessenger messengerOf(BuildContext context) {
    final messenger = context
        .dependOnInheritedWidgetOfExactType<_InheritedSnackbarMessenger>()
        ?.messenger;

    assert(
      messenger != null,
      'No SnackbarMessenger provided by the AppSnackbarTheater found in'
      ' context, provide AppSnackbarTheater near the root of the widget tree',
    );

    return messenger!;
  }

  @override
  State<AppSnackbarTheater> createState() => _AppSnackbarTheaterState();
}

class _AppSnackbarTheaterState extends State<AppSnackbarTheater>
    with TickerProviderStateMixin {
  late final SnackbarMessenger _messenger;

  @override
  void initState() {
    super.initState();
    _messenger = SnackbarMessenger(vsync: this);
  }

  @override
  void dispose() {
    _messenger.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedSnackbarMessenger(
      messenger: _messenger,
      child: widget.child,
    );
  }
}

class _InheritedSnackbarMessenger extends InheritedWidget {
  const _InheritedSnackbarMessenger({
    required this.messenger,
    required super.child,
  });

  final SnackbarMessenger messenger;

  @override
  bool updateShouldNotify(_InheritedSnackbarMessenger oldWidget) =>
      messenger != oldWidget.messenger;
}

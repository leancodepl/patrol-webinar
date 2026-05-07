import 'package:app_design_system/src/widgets/snackbar/snackbar.dart';
import 'package:app_design_system/src/widgets/snackbar/snackbar_theater.dart';
import 'package:flutter/widgets.dart';

extension AppSnackbarBuildContextExtension on BuildContext {
  /// Push a snackbar to the queue for displaying it on the scene.
  ///
  /// If the snackbar has been pushed with `crossPage` set to true, it will be
  /// shown on all pages until it is closed. If it is not cross-page, it will
  /// be shown on the current page only and removed when navigating to another
  /// page.
  ///
  /// `snackbar` is the snackbar to be displayed. It shall not have `onCloseTap`
  /// set. Internally `onCloseTap` is overwritten with a callback that closes the
  /// snackbar. Because of that we validate if `onCloseTap` is set so that the
  /// developer doesn't pass it unnecessarily.
  Future<void> pushSnackbar(AppSnackbar snackbar, {bool crossPage = true}) {
    assert(
      snackbar.onCloseTap == null,
      "Don't set onCloseTap when pushing snackbar. It will be set"
      ' automatically anyways',
    );

    final accessibleNavigation = MediaQuery.accessibleNavigationOf(this);

    // If accessible navigation is enabled, the snackbar is shown for 10x longer
    // to make sure that users with cognitive limitations, for example, have
    // sufficient time to familiarize themselves with the snackbar content.
    //
    // For more information see:
    // https://www.w3.org/TR/WCAG22/#timing-adjustable
    final duration = switch (accessibleNavigation) {
      true => AppSnackbar.activeDuration * 10,
      false => AppSnackbar.activeDuration,
    };

    return AppSnackbarTheater.messengerOf(
      this,
    ).push(crossPage: crossPage, duration: duration, snackbar: snackbar);
  }

  /// Clear the snackbar queue.
  void clearSnackbars() {
    AppSnackbarTheater.messengerOf(this).clear();
  }

  /// Pop the topmost snackbar from the queue.
  void popSnackbar() {
    AppSnackbarTheater.messengerOf(this).pop();
  }
}

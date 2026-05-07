import 'package:flutter/widgets.dart';
import 'package:fts/common/config/app_global_keys.dart';
import 'package:provider/provider.dart';

extension SnackbarPaddingContextExtension on BuildContext {
  EdgeInsets get snackbarPadding {
    final safeArea = MediaQuery.paddingOf(this);

    final navigationBarRenderBox =
        read<AppGlobalKeys>().navigationBarKey.currentContext
                ?.findRenderObject()
            as RenderBox?;

    final navigationBarHeight = navigationBarRenderBox?.size.height ?? 0;

    return safeArea + EdgeInsets.only(bottom: navigationBarHeight + 16);
  }
}

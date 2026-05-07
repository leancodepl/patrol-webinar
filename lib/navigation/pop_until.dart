import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension PopUntilExtension on BuildContext {
  Future<void> popUntil(bool Function(GoRouterState state) predicate) async {
    final goRouter = GoRouter.of(this);

    while (!predicate(goRouter.state)) {
      if (goRouter.canPop()) {
        goRouter.pop();
      } else {
        break;
      }
      await WidgetsBinding.instance.endOfFrame;
    }
  }
}

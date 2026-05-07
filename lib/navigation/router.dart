import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:fts/common/config/app_global_keys.dart';
import 'package:fts/common/keys/page_ids.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/navigation/redirections.dart';
import 'package:fts/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class _CubitNotifier extends ChangeNotifier {
  _CubitNotifier(this._cubit) {
    _cubit.stream.listen((state) {
      notifyListeners();
    });
  }

  final AuthCubit _cubit;

  AuthState get state => _cubit.state;
}

GoRouter useGoRouter({
  required AppGlobalKeys globalKeys,
  required AuthCubit authCubit,
  required List<NavigatorObserver> observers,
  required String initialLocation,
}) {
  return useMemoized(
    () => GoRouter(
      navigatorKey: globalKeys.navigatorKey,
      initialLocation: initialLocation,
      routes: $appRoutes,
      observers: observers,
      debugLogDiagnostics: kDebugMode,
      redirect: (context, state) => getRedirection(
        context,
        state.uri.toString(),
        queryParams: state.uri.queryParameters,
      ),
      refreshListenable: _CubitNotifier(authCubit),
    ),
  );
}

class AppRoute<T> extends MaterialPageRoute<T> {
  AppRoute._({
    required PageId id,
    required super.builder,
    required super.settings,
  }) : id = id.name;

  final String id;
}

abstract class AppGoRouteData extends GoRouteData {
  const AppGoRouteData({required this.id, required this.arguments});

  final PageId id;
  final Record arguments;

  @override
  @nonVirtual
  Page<void> buildPage(BuildContext context, GoRouterState state) => AppPage(
    id: id,
    builder: (context) => buildAppPage(context, state),
    key: arguments != () ? ValueKey((id, arguments)) : ValueKey(id),
  );

  Widget buildAppPage(BuildContext context, GoRouterState state);
}

class AppPage<T> extends Page<T> {
  const AppPage({super.key, required this.id, required this.builder});

  final PageId id;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) =>
      AppRoute._(id: id, builder: builder, settings: this);
}

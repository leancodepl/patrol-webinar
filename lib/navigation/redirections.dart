import 'package:flutter/widgets.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/navigation/routes.dart';
import 'package:provider/provider.dart';

typedef Redirection =
    String? Function(
      BuildContext context,
      String location, {
      Map<String, String>? queryParams,
    });

String? getRedirection(
  BuildContext context,
  String location, {
  Map<String, String>? queryParams,
}) {
  final authCubit = context.read<AuthCubit>();
  final authState = authCubit.state;
  final isAuthenticated = authState is AuthStateLoggedIn;

  final authenticatedRedirections = <Redirection>[];

  final redirections = <Redirection>[
    authStateRedirect,
    if (isAuthenticated) ...authenticatedRedirections,
  ];

  for (final redirection in redirections) {
    final newLocation = redirection(
      context,
      location,
      queryParams: queryParams,
    );
    if (newLocation != null && newLocation != location) {
      return newLocation;
    }
  }
  return null;
}

final _authenticatedRoutes = <String>[];

final _routesNotAffectedByAuthorization = [const VerifyRoute().location];

String? authStateRedirect(
  BuildContext context,
  String location, {
  Map<String, String>? queryParams,
}) {
  final locationWithoutQueryParams = location.split('?').first;
  final isRouteNotAffectedByAuthorization = _routesNotAffectedByAuthorization
      .contains(locationWithoutQueryParams);
  final isUnauthenticatedRoute = !_authenticatedRoutes.contains(
    locationWithoutQueryParams,
  );

  final authCubit = context.read<AuthCubit>();
  final authState = authCubit.state;
  final isAuthenticated = authState is AuthStateLoggedIn;

  if (isRouteNotAffectedByAuthorization) {
    return null;
  }

  if (!isUnauthenticatedRoute && !isAuthenticated) {
    return const LoginRoute().location;
  }

  return null;
}

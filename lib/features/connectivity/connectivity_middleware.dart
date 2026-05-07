import 'package:cqrs/cqrs.dart';
import 'package:fts/features/connectivity/connectivity_cubit.dart';

class ConnectivityCqrsMiddleware implements CqrsMiddleware {
  ConnectivityCqrsMiddleware({required this.connectivityCubit});

  final ConnectivityCubit connectivityCubit;

  @override
  Future<QueryResult<T>> handleQueryResult<T>(QueryResult<T> result) {
    final apiResult = switch (result) {
      QueryFailure(:final error) =>
        error == QueryError.network
            ? CqrsConnectivityResult.networkError
            : null,
      _ => CqrsConnectivityResult.success,
    };
    if (apiResult != null) {
      connectivityCubit.onApiResult(apiResult);
    }
    return Future.value(result);
  }

  @override
  Future<CommandResult> handleCommandResult(CommandResult result) {
    final apiResult = switch (result) {
      CommandFailure(:final error) =>
        error == CommandError.network
            ? CqrsConnectivityResult.networkError
            : null,
      _ => CqrsConnectivityResult.success,
    };
    if (apiResult != null) {
      connectivityCubit.onApiResult(apiResult);
    }
    return Future.value(result);
  }

  @override
  Future<OperationResult<T>> handleOperationResult<T>(
    OperationResult<T> result,
  ) {
    final apiResult = switch (result) {
      OperationFailure(:final error) =>
        error == OperationError.network
            ? CqrsConnectivityResult.networkError
            : null,
      _ => CqrsConnectivityResult.success,
    };
    if (apiResult != null) {
      connectivityCubit.onApiResult(apiResult);
    }
    return Future.value(result);
  }
}

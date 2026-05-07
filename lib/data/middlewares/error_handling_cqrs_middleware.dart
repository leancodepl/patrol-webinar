import 'package:cqrs/cqrs.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:fts/widgets/widgets.dart';

class ErrorHandlingCqrsMiddleware extends CqrsMiddleware {
  const ErrorHandlingCqrsMiddleware(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  AppLocalizations? get _s => switch (_navigatorKey.currentContext) {
    final context? => l10n(context),
    _ => null,
  };

  @override
  Future<QueryResult<T>> handleQueryResult<T>(QueryResult<T> result) {
    if (result case QueryFailure(:final error)) {
      switch (error) {
        case QueryError.network:
          // Handled by `ConnectivityCqrsMiddleware`
          break;
        case QueryError.authentication:
          _handleAutheticationError();
        case QueryError.authorization:
          _handleAuthorizationError();
        case QueryError.unknown:
          _handleUnknownError();
      }
    }

    return Future.value(result);
  }

  @override
  Future<CommandResult> handleCommandResult(CommandResult result) {
    if (result case CommandFailure(:final error)) {
      switch (error) {
        case CommandError.network:
          // Handled by `ConnectivityCqrsMiddleware`
          break;
        case CommandError.authentication:
          _handleAutheticationError();
        case CommandError.authorization:
          _handleAuthorizationError();
        case CommandError.unknown:
          _handleUnknownError();
        default:
      }
    }

    return Future.value(result);
  }

  @override
  Future<OperationResult<T>> handleOperationResult<T>(
    OperationResult<T> result,
  ) {
    if (result case OperationFailure(:final error)) {
      switch (error) {
        case OperationError.network:
          // Handled by `ConnectivityCqrsMiddleware`
          break;
        case OperationError.authentication:
          _handleAutheticationError();
        case OperationError.authorization:
          _handleAuthorizationError();
        case OperationError.unknown:
          _handleUnknownError();
      }
    }

    return Future.value(result);
  }

  void _handleAutheticationError() {
    // TODO: Call logout() here
  }

  void _handleAuthorizationError() {
    if (_s case final s?) {
      _showSnackBar(s.error_handling_authorization);
    }

    // TODO: Navigate to main screen
  }

  void _handleUnknownError() {
    if (_s case final s?) {
      _showSnackBar(s.error_handling_unknown);
    }
  }

  void _showSnackBar(String text) {
    _navigatorKey.currentContext?.pushSnackbar(
      AppSnackbar(
        text: text,
        type: AppSnackbarType.danger,
        padding: _navigatorKey.currentContext?.snackbarPadding,
      ),
    );
  }
}

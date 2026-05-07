import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class PasskeyLoginCubit extends Cubit<PasskeyLoginState>
    with BlocPresentationMixin<PasskeyLoginState, PasskeyLoginEvent> {
  PasskeyLoginCubit({
    required this.kratosClient,
    required this.authCubit,
    required this.passkeyCredentialManager,
  }) : super(PasskeyLoginState.idle);

  final KratosClient kratosClient;
  final AuthCubit authCubit;
  final PasskeyCredentialManager passkeyCredentialManager;

  Future<void> login() async {
    if (state == PasskeyLoginState.inProgress) {
      return;
    }

    emit(PasskeyLoginState.inProgress);

    final loginResult = await kratosClient.loginWithPasskey(
      passkeyCallback: _passkeyCallback,
    );

    switch (loginResult) {
      case PasskeyLoginSuccessResult():
        authCubit.emit(const AuthStateLoggedIn());
        emitPresentation(const PasskeyLoginEventSuccess());
      case PasskeyLoginVerifyEmailResult():
        emitPresentation(
          PasskeyLoginEventVerifyEmail(flowId: loginResult.flowId),
        );
      case PasskeyLoginErrorResult():
        emitPresentation(
          PasskeyLoginEventError(
            message: loginResult.generalErrors.firstOrNull,
          ),
        );
      case PasskeyLoginPasskeyErrorResult():
      case PasskeyLoginUnknownErrorResult():
      case PasskeyLoginIdentityDisabledResult():
        emitPresentation(const PasskeyLoginEventError());
      case PasskeyLoginCancelledResult():
        break;
    }

    emit(PasskeyLoginState.idle);
  }

  Future<PasskeyCallbackResult> _passkeyCallback(
    Map<String, dynamic> options,
  ) async {
    final result = await passkeyCredentialManager.request(options);

    switch (result) {
      case PasskeyRequestSuccess(:final publicKeyJson):
        return PasskeyCallbackSuccessResult(publicKeyJson);
      case PasskeyRequestCancelled():
        return const PasskeyCallbackCancelledResult();
      case PasskeyRequestFailure():
        return const PasskeyCallbackErrorResult();
      case PasskeyRequestNoCredentialsAvailable():
        emitPresentation(const PasskeyLoginEventNoCredentialsAvailable());
        return const PasskeyCallbackCancelledResult();
    }
  }
}

enum PasskeyLoginState { idle, inProgress }

sealed class PasskeyLoginEvent {
  const PasskeyLoginEvent();
}

final class PasskeyLoginEventSuccess extends PasskeyLoginEvent {
  const PasskeyLoginEventSuccess();
}

final class PasskeyLoginEventVerifyEmail extends PasskeyLoginEvent {
  const PasskeyLoginEventVerifyEmail({required this.flowId});

  final String flowId;
}

final class PasskeyLoginEventNoCredentialsAvailable extends PasskeyLoginEvent {
  const PasskeyLoginEventNoCredentialsAvailable();
}

final class PasskeyLoginEventError extends PasskeyLoginEvent {
  const PasskeyLoginEventError({this.message});

  final KratosMessage? message;
}

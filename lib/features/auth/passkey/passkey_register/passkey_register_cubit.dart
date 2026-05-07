import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/features/auth/common/get_trait_error.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/common/trait.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:fts/features/auth/passkey/passkey_register/passkey_register_form_cubit.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class PasskeyRegisterCubit extends Cubit<PasskeyRegisterState>
    with BlocPresentationMixin<PasskeyRegisterState, PasskeyRegisterEvent> {
  PasskeyRegisterCubit({
    required this.kratosClient,
    required this.authCubit,
    required this.passkeyCredentialManager,
  }) : super(const PasskeyRegisterStateIdle());

  final KratosClient kratosClient;
  final AuthCubit authCubit;
  final PasskeyCredentialManager passkeyCredentialManager;

  final formCubit = PasskeyRegisterFormCubit();

  Future<void> registerWithPasskey() async {
    if (!formCubit.validate()) {
      return;
    }

    if (state is PasskeyRegisterStateInProgress) {
      return;
    }

    emit(const PasskeyRegisterStateInProgress());

    final traits = {
      Trait.email.key: formCubit.email.state.value,
      Trait.givenName.key: formCubit.firstName.state.value,
      Trait.familyName.key: formCubit.lastName.state.value,
      Trait.regulationsAccepted.key: formCubit.checkbox.state.value,
    };

    final registerProfileResult = await kratosClient.registerWithProfile(
      traits: traits,
    );

    switch (registerProfileResult) {
      case RegistrationLinkAccountResult():
        break;
      case RegistrationErrorResult():
        _setErrors(registerProfileResult.fieldErrors);

        final kratosError = registerProfileResult.generalErrors.firstOrNull;
        emit(
          state.withError(
            kratosError?.let(PasskeyRegisterKratosError.new) ??
                const PasskeyRegisterUnknownError(),
          ),
        );
        return;
      default:
        emit(state.withError(const PasskeyRegisterUnknownError()));
        return;
    }

    final passkeyCreationOptions =
        registerProfileResult.flowInfo.passkeyCreationOptions;

    if (passkeyCreationOptions == null) {
      emit(state.withError(const PasskeyRegisterUnknownError()));
      return;
    }

    final credentialResult = await passkeyCredentialManager.create(
      passkeyCreationOptions,
    );

    final String credential;
    switch (credentialResult) {
      case PasskeyCreationSuccess():
        credential = credentialResult.publicKeyJson;
      case PasskeyCreationFailure():
        emit(state.withError(const PasskeyRegisterUnknownError()));
        return;
      case PasskeyCreationCancelled():
        emit(const PasskeyRegisterStateIdle());
        return;
    }

    final result = await kratosClient.registerWithPasskey(
      credentialJson: credential,
      flowInfo: registerProfileResult.flowInfo,
      traits: traits,
    );

    switch (result) {
      case RegistrationVerifyEmailResult():
        emitPresentation(
          PasskeyRegisterEventVerifyEmail(
            email: result.emailToVerify,
            flowId: result.flowId,
          ),
        );
      case RegistrationSuccessResult():
        authCubit.emit(const AuthStateLoggedIn());
        emitPresentation(const PasskeyRegisterEventSuccess());
      case RegistrationCancelledResult():
        emit(const PasskeyRegisterStateIdle());
      case RegistrationErrorResult():
        _setErrors(result.fieldErrors);

        final kratosError = result.generalErrors.firstOrNull;
        emit(
          state.withError(
            kratosError?.let(PasskeyRegisterKratosError.new) ??
                const PasskeyRegisterUnknownError(),
          ),
        );
      case RegistrationSocialFinishResult():
      case RegistrationLinkAccountResult():
      case RegistrationUnknownErrorResult():
        emit(state.withError(const PasskeyRegisterUnknownError()));
    }
  }

  void _setErrors(List<(String, KratosMessage)> fieldErrors) {
    getTraitError(
      fieldErrors,
      Trait.email,
    )?.let((error) => formCubit.email.setError(KratosValidationError(error)));
    getTraitError(fieldErrors, Trait.givenName)?.let(
      (error) => formCubit.firstName.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.familyName)?.let(
      (error) => formCubit.lastName.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.regulationsAccepted)?.let(
      (error) => formCubit.checkbox.setError(KratosValidationError(error)),
    );
  }

  @override
  Future<void> close() async {
    await formCubit.close();
    return super.close();
  }
}

sealed class PasskeyRegisterState with EquatableMixin {
  const PasskeyRegisterState({this.error});

  final PasskeyRegisterGeneralError? error;

  PasskeyRegisterState withError(PasskeyRegisterGeneralError error) =>
      switch (this) {
        PasskeyRegisterStateIdle() => PasskeyRegisterStateIdle(error: error),
        PasskeyRegisterStateInProgress() => PasskeyRegisterStateInProgress(
          error: error,
        ),
      };

  @override
  List<Object?> get props => [error];
}

final class PasskeyRegisterStateIdle extends PasskeyRegisterState {
  const PasskeyRegisterStateIdle({super.error});
}

final class PasskeyRegisterStateInProgress extends PasskeyRegisterState {
  const PasskeyRegisterStateInProgress({super.error});
}

sealed class PasskeyRegisterGeneralError {
  const PasskeyRegisterGeneralError();
}

class PasskeyRegisterUnknownError extends PasskeyRegisterGeneralError {
  const PasskeyRegisterUnknownError();
}

class PasskeyRegisterKratosError extends PasskeyRegisterGeneralError {
  const PasskeyRegisterKratosError(this.error);

  final KratosMessage error;
}

sealed class PasskeyRegisterEvent {
  const PasskeyRegisterEvent();
}

final class PasskeyRegisterEventSuccess extends PasskeyRegisterEvent {
  const PasskeyRegisterEventSuccess();
}

final class PasskeyRegisterEventVerifyEmail extends PasskeyRegisterEvent {
  const PasskeyRegisterEventVerifyEmail({
    required this.email,
    required this.flowId,
  });

  final String? email;
  final String? flowId;
}

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/features/auth/common/get_field_error.dart';
import 'package:fts/features/auth/common/get_trait_error.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/common/trait.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:fts/features/auth/register/register_password_form_cubit.dart';
import 'package:fts/features/auth/register/register_profile_form_cubit.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

part 'register_cubit.g.dart';

class RegisterCubit extends Cubit<RegisterState>
    with BlocPresentationMixin<RegisterState, RegisterEvent> {
  RegisterCubit({
    required this.kratosClient,
    required this.authCubit,
    required this.passkeyCredentialManager,
  }) : super(const RegisterStateProfileEnter(inProgress: false));

  final KratosClient kratosClient;
  final AuthCubit authCubit;
  final PasskeyCredentialManager passkeyCredentialManager;

  final profileFormCubit = RegisterProfileFormCubit();
  final passwordFormCubit = RegisterPasswordFormCubit();

  Future<void> registerProfile() async {
    if (!profileFormCubit.validate()) {
      return;
    }

    final currentState = state;

    if (currentState is! RegisterStateProfileEnter || currentState.inProgress) {
      return;
    }

    emit(currentState.copyWith(inProgress: true));

    final registerProfileResult = await kratosClient.registerWithProfile(
      traits: {
        Trait.email.key: profileFormCubit.email.state.value,
        Trait.givenName.key: profileFormCubit.firstName.state.value,
        Trait.familyName.key: profileFormCubit.lastName.state.value,
        Trait.regulationsAccepted.key: profileFormCubit.checkbox.state.value,
      },
    );

    switch (registerProfileResult) {
      case RegistrationLinkAccountResult():
        break;
      case RegistrationErrorResult():
        _setErrors(registerProfileResult.fieldErrors);
        emit(
          currentState.copyWith(
            generalError: registerProfileResult.generalErrors.firstOrNull?.let(
              RegisterKratosError.new,
            ),
            inProgress: false,
          ),
        );
        return;
      default:
        emit(
          currentState.copyWith(
            generalError: const RegisterUnknownError(),
            inProgress: false,
          ),
        );
        return;
    }
    emit(
      RegisterStatePasswordEnter(
        email: profileFormCubit.email.state.value,
        firstName: profileFormCubit.firstName.state.value,
        lastName: profileFormCubit.lastName.state.value,
        regulationsAccepted: profileFormCubit.checkbox.state.value,
        flowInfo: registerProfileResult.flowInfo,
        inProgress: false,
      ),
    );
  }

  Future<void> registerWithPasskey() async {
    final passwordState = state;

    if (passwordState is! RegisterStatePasswordEnter) {
      return;
    }

    emit(passwordState.copyWith(inProgress: true));

    final passkeyCreationOptions =
        passwordState.flowInfo.passkeyCreationOptions;

    if (passkeyCreationOptions == null) {
      emit(
        passwordState.copyWith(
          generalError: const RegisterUnknownError(),
          inProgress: false,
        ),
      );
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
        emit(
          passwordState.copyWith(
            generalError: const RegisterUnknownError(),
            inProgress: false,
          ),
        );
        return;
      case PasskeyCreationCancelled():
        emit(passwordState);
        return;
    }

    final result = await kratosClient.registerWithPasskey(
      credentialJson: credential,
      flowInfo: passwordState.flowInfo,
      traits: {
        Trait.email.key: passwordState.email,
        Trait.givenName.key: passwordState.firstName,
        Trait.familyName.key: passwordState.lastName,
        Trait.regulationsAccepted.key: passwordState.regulationsAccepted,
      },
    );

    switch (result) {
      case RegistrationVerifyEmailResult():
        emitPresentation(
          RegisterEventVerifyEmail(
            email: result.emailToVerify,
            flowId: result.flowId,
          ),
        );
      case RegistrationSuccessResult():
        authCubit.emit(const AuthStateLoggedIn());
        emitPresentation(const RegisterEventSuccess());
      case RegistrationCancelledResult():
        emit(passwordState);
      case RegistrationErrorResult():
        _setErrors(result.fieldErrors);

        final kratosError = result.generalErrors.firstOrNull;
        emit(
          passwordState.copyWith(
            generalError:
                kratosError?.let(RegisterKratosError.new) ??
                const RegisterUnknownError(),
            inProgress: false,
          ),
        );
      case RegistrationSocialFinishResult():
      case RegistrationLinkAccountResult():
      case RegistrationUnknownErrorResult():
        emit(
          passwordState.copyWith(
            generalError: const RegisterUnknownError(),
            inProgress: false,
          ),
        );
    }
  }

  Future<void> registerWithPassword() async {
    final passwordState = state;

    if (!passwordFormCubit.validate() ||
        passwordState is! RegisterStatePasswordEnter) {
      return;
    }

    emit(passwordState.copyWith(inProgress: true));

    final result = await kratosClient.registerWithPassword(
      password: passwordFormCubit.password.state.value,
      traits: {
        Trait.email.key: passwordState.email,
        Trait.givenName.key: passwordState.firstName,
        Trait.familyName.key: passwordState.lastName,
        Trait.regulationsAccepted.key: passwordState.regulationsAccepted,
      },
    );

    switch (result) {
      case RegistrationVerifyEmailResult():
        emitPresentation(
          RegisterEventVerifyEmail(
            email: result.emailToVerify,
            flowId: result.flowId,
          ),
        );
      case RegistrationSuccessResult():
        authCubit.emit(const AuthStateLoggedIn());
        emitPresentation(const RegisterEventSuccess());
      case RegistrationCancelledResult():
        emit(passwordState);
      case RegistrationErrorResult():
        _setErrors(result.fieldErrors);
        emit(
          passwordState.copyWith(
            generalError: result.generalErrors.firstOrNull?.let(
              RegisterKratosError.new,
            ),
            inProgress: false,
          ),
        );
      case RegistrationSocialFinishResult():
      case RegistrationLinkAccountResult():
      case RegistrationUnknownErrorResult():
        emit(
          passwordState.copyWith(
            generalError: const RegisterUnknownError(),
            inProgress: false,
          ),
        );
    }
  }

  void _setErrors(List<(String, KratosMessage)> fieldErrors) {
    getTraitError(fieldErrors, Trait.email)?.let(
      (error) => profileFormCubit.email.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.givenName)?.let(
      (error) =>
          profileFormCubit.firstName.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.familyName)?.let(
      (error) =>
          profileFormCubit.lastName.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.regulationsAccepted)?.let(
      (error) =>
          profileFormCubit.checkbox.setError(KratosValidationError(error)),
    );
    getFieldError(fieldErrors, 'password')?.let(
      (error) =>
          passwordFormCubit.password.setError([KratosValidationError(error)]),
    );
  }

  @override
  Future<void> close() async {
    await profileFormCubit.close();
    await passwordFormCubit.close();
    return super.close();
  }
}

sealed class RegisterState with EquatableMixin {
  const RegisterState({required this.inProgress, this.generalError});

  final bool inProgress;
  final RegisterGeneralError? generalError;

  @override
  List<Object?> get props => [inProgress, generalError];
}

@CopyWith()
final class RegisterStateProfileEnter extends RegisterState {
  const RegisterStateProfileEnter({
    required super.inProgress,
    super.generalError,
  });
}

@CopyWith()
final class RegisterStatePasswordEnter extends RegisterState {
  const RegisterStatePasswordEnter({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.regulationsAccepted,
    required this.flowInfo,
    required super.inProgress,
    super.generalError,
  });

  final String email;
  final String firstName;
  final String lastName;
  final bool regulationsAccepted;
  final AuthFlowInfo flowInfo;

  @override
  List<Object?> get props => [
    super.props,
    email,
    firstName,
    lastName,
    regulationsAccepted,
    flowInfo,
  ];
}

sealed class RegisterGeneralError {
  const RegisterGeneralError();
}

class RegisterUnknownError extends RegisterGeneralError {
  const RegisterUnknownError();
}

class RegisterKratosError extends RegisterGeneralError {
  const RegisterKratosError(this.error);

  final KratosMessage error;
}

sealed class RegisterEvent {
  const RegisterEvent();
}

final class RegisterEventSuccess extends RegisterEvent {
  const RegisterEventSuccess();
}

final class RegisterEventVerifyEmail extends RegisterEvent {
  const RegisterEventVerifyEmail({required this.email, required this.flowId});

  final String? email;
  final String? flowId;
}

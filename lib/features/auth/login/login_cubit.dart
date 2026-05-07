import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/features/auth/common/get_field_error.dart';
import 'package:fts/features/auth/common/get_trait_error.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/common/trait.dart';
import 'package:fts/features/auth/login/login_form_cubit.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

part 'login_cubit.g.dart';

class LoginCubit extends Cubit<LoginState>
    with BlocPresentationMixin<LoginState, LoginEvent> {
  LoginCubit({required this.kratosClient, required this.authCubit})
    : super(const LoginStateInitial());

  final KratosClient kratosClient;
  final AuthCubit authCubit;

  final formCubit = LoginFormCubit();

  Future<void> login() async {
    if (!formCubit.validate()) {
      return;
    }

    var currentState = state;
    if (currentState is! LoginStateInitial) {
      return;
    }

    if (currentState.inProgress) {
      return;
    }

    emit(currentState = currentState.copyWith(inProgress: true));

    final email = formCubit.email.state.value;
    final password = formCubit.password.state.value;

    final result = await kratosClient.loginWithPassword(email, password);

    switch (result) {
      case LoginVerifyEmailResult():
        emit(LoginStateUnverified(email: email));
      case LoginSuccessResult():
        authCubit.emit(const AuthStateLoggedIn());
        emitPresentation(const LoginEventSuccess());
      case LoginErrorResult():
        _setErrors(result.fieldErrors);

        emit(
          currentState = currentState.copyWith(
            generalError: result.generalErrors.firstOrNull?.let(
              LoginKratosError.new,
            ),
            inProgress: false,
          ),
        );
      case LoginUnknownErrorResult() || LoginIdentityDisabledResult():
        emit(
          currentState = currentState.copyWith(
            generalError: const LoginUnknownError(),
            inProgress: false,
          ),
        );
    }
  }

  void _setErrors(List<(String, KratosMessage)> fieldErrors) {
    getFieldError(fieldErrors, 'password')?.let(
      (error) => formCubit.password.setError([KratosValidationError(error)]),
    );
    getTraitError(
      fieldErrors,
      Trait.email,
    )?.let((error) => formCubit.email.setError(KratosValidationError(error)));
  }

  @override
  Future<void> close() async {
    await formCubit.close();
    return super.close();
  }
}

sealed class LoginState with EquatableMixin {
  const LoginState();
}

@CopyWith()
final class LoginStateInitial extends LoginState {
  const LoginStateInitial({
    this.flowInfo,
    this.generalError,
    this.inProgress = false,
    this.email,
  });

  final AuthFlowInfo? flowInfo;
  final LoginGeneralError? generalError;
  final bool inProgress;
  final String? email;

  @override
  List<Object?> get props => [flowInfo, generalError, inProgress, email];
}

final class LoginStateUnverified extends LoginState {
  const LoginStateUnverified({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

sealed class LoginGeneralError {
  const LoginGeneralError();
}

class LoginUnknownError extends LoginGeneralError {
  const LoginUnknownError();
}

class LoginKratosError extends LoginGeneralError {
  const LoginKratosError(this.error);

  final KratosMessage error;
}

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginEventSuccess extends LoginEvent {
  const LoginEventSuccess();
}

final class LoginEventVerifyEmail extends LoginEvent {
  const LoginEventVerifyEmail({required this.email});

  final String? email;
}

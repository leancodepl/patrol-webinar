import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/common/util/profile_traits_extension.dart';
import 'package:fts/features/auth/reauthorize/reauthorize_form_cubit.dart';
import 'package:fts/features/auth/user/user_repository.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

part 'reauthorize_cubit.g.dart';

class ReauthorizeCubit extends Cubit<ReauthorizeState>
    with BlocPresentationMixin<ReauthorizeState, ReauthorizeEvent> {
  ReauthorizeCubit({required this.kratosClient, required this.userRepository})
    : super(const ReauthorizeState());

  final KratosClient kratosClient;
  final UserRepository userRepository;

  final formCubit = ReauthorizeFormCubit();

  Future<void> reauthorizeWithPassword() async {
    if (!formCubit.validate()) {
      return;
    }

    var currentState = state;

    if (currentState.inProgress) {
      return;
    }

    emit(currentState = currentState.copyWith(inProgress: true));
    final profile = await userRepository.getUser();
    if (profile is! UserProfileData) {
      emit(
        currentState = currentState.copyWith(
          generalError: const LoginUnknownError(),
          inProgress: false,
        ),
      );
      return;
    }

    final email = profile.traits.email ?? '';
    final password = formCubit.password.state.value;

    final result = await kratosClient.loginWithPassword(
      email,
      password,
      refresh: true,
    );

    switch (result) {
      case LoginSuccessResult():
        emitPresentation(ReauthorizeEvent.success);
      case LoginErrorResult():
        _getFieldError(result.fieldErrors, 'password')?.let(
          (error) =>
              formCubit.password.setError([KratosValidationError(error)]),
        );

        emit(
          currentState = currentState.copyWith(
            generalError: result.generalErrors.firstOrNull?.let(
              LoginKratosError.new,
            ),
            inProgress: false,
          ),
        );
      case LoginUnknownErrorResult():
      case LoginVerifyEmailResult():
      case LoginIdentityDisabledResult():
        emit(
          currentState = currentState.copyWith(
            generalError: const LoginUnknownError(),
            inProgress: false,
          ),
        );
    }
  }

  KratosMessage? _getFieldError(
    List<(String, KratosMessage)> fieldErrors,
    String field,
  ) {
    return fieldErrors.firstWhereOrNull((error) => error.$1 == field)?.$2;
  }

  @override
  Future<void> close() async {
    await formCubit.close();
    return super.close();
  }
}

@CopyWith()
final class ReauthorizeState with EquatableMixin {
  const ReauthorizeState({
    this.flowInfo,
    this.generalError,
    this.inProgress = false,
  });

  final AuthFlowInfo? flowInfo;
  final LoginGeneralError? generalError;
  final bool inProgress;

  @override
  List<Object?> get props => [flowInfo, generalError, inProgress];
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

enum ReauthorizeEvent { success }

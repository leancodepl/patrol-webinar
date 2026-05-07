import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/auth/menu/change_password/change_password_form_cubit.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState>
    with BlocPresentationMixin<ChangePasswordState, ChangePasswordEvent> {
  ChangePasswordCubit({required this.kratosClient})
    : super(ChangePasswordState.initial);

  final KratosClient kratosClient;

  final formCubit = ChangePasswordFormCubit();

  Future<void> submit() async {
    if (!formCubit.validate()) {
      return;
    }

    emit(ChangePasswordState.loading);

    final password = formCubit.password.state.value;
    final result = await kratosClient.updatePassword(password: password);

    switch (result) {
      case UpdateSuccess():
        emitPresentation(const ChangePasswordEventSuccess());
      case UpdateRequiresReauthorization():
        emitPresentation(const ChangePasswordEventAuthorizationNeeded());
      case UpdateFailure():
        emitPresentation(ChangePasswordEventError(result.error));
    }
  }

  @override
  Future<void> close() async {
    await formCubit.close();
    return super.close();
  }
}

enum ChangePasswordState { initial, loading }

/// Events

sealed class ChangePasswordEvent {
  const ChangePasswordEvent();
}

final class ChangePasswordEventSuccess extends ChangePasswordEvent {
  const ChangePasswordEventSuccess();
}

final class ChangePasswordEventError extends ChangePasswordEvent {
  const ChangePasswordEventError(this.kratosError);

  final KratosMessage? kratosError;
}

final class ChangePasswordEventAuthorizationNeeded extends ChangePasswordEvent {
  const ChangePasswordEventAuthorizationNeeded();
}

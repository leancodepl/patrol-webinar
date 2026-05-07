import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/features/auth/recovery/recovery_email_form_cubit.dart';
import 'package:fts/features/auth/recovery/recovery_new_password_form_cubit.dart';
import 'package:leancode_forms/leancode_forms.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class RecoveryCubit extends Cubit<RecoveryState>
    with BlocPresentationMixin<RecoveryState, RecoveryEvent> {
  RecoveryCubit({required this.kratosClient})
    : super(const RecoveryStateInitial());

  final KratosClient kratosClient;

  final recoveryEmailFormCubit = RecoveryEmailFormCubit();
  final recoveryNewPasswordFormCubit = RecoveryNewPasswordFormCubit();
  final code = TextFieldCubit<ValidationError>(
    validator: filled(
      const LocalValidationError(LocalValidationErrorType.empty),
    ),
  );

  Future<void> getRecoveryFlow() async {
    final result = await kratosClient.getRecoveryFlow();
    switch (result) {
      case RecoveryFlow _:
        emit(RecoveryStateEmailEntry(flowId: result.flowId));
      case RecoveryFlowError _:
        return;
    }
  }

  Future<void> sendEmail() async {
    if (!recoveryEmailFormCubit.validate()) {
      return;
    }

    if (state case final RecoveryStateEmailEntry state) {
      emit(const RecoveryStateLoading());
      final result = await kratosClient.sendEmailRecoveryFlow(
        flowId: state.flowId,
        email: recoveryEmailFormCubit.email.state.value,
      );
      if (result) {
        emit(RecoveryStatePinEntry(flowId: state.flowId));
      }
    }
  }

  Future<void> resendCode() async {
    final result = await kratosClient.getRecoveryFlow();
    if (result case RecoveryFlow(:final flowId)) {
      final emailResult = await kratosClient.sendEmailRecoveryFlow(
        flowId: flowId,
        email: recoveryEmailFormCubit.email.state.value,
      );
      if (emailResult) {
        emit(RecoveryStatePinEntry(flowId: flowId));
      }
    }
  }

  Future<void> submitCode() async {
    if (!code.validate()) {
      return;
    }

    if (state case final RecoveryStatePinEntry state) {
      emit(const RecoveryStateLoading());

      final result = await kratosClient.sendCodeRecoveryFlow(
        flowId: state.flowId,
        code: code.state.value,
      );
      switch (result) {
        case SettingsFlowResultError():
          emit(const RecoveryStateFlowError());
          emitPresentation(RecoveryEvent.error);
        case SettingsFlowResultData():
          emit(RecoveryStateFlowPinResult(flow: result));
      }
    }
  }

  Future<void> setNewPassword() async {
    if (!recoveryNewPasswordFormCubit.validate()) {
      return;
    }

    if (state case final RecoveryStateFlowPinResult state) {
      emit(const RecoveryStateLoading());

      final result = await kratosClient.sendNewPasswordSettingsFlow(
        flow: state.flow,
        newPassword: recoveryNewPasswordFormCubit.password.state.value,
      );
      if (result) {
        emit(const RecoveryStateSuccess());
        emitPresentation(RecoveryEvent.success);
      } else {
        emit(const RecoveryStateFlowError());
        emitPresentation(RecoveryEvent.error);
      }
    }
  }

  @override
  Future<void> close() async {
    await recoveryEmailFormCubit.close();
    await recoveryNewPasswordFormCubit.close();
    return super.close();
  }
}

sealed class RecoveryState with EquatableMixin {
  const RecoveryState();
}

final class RecoveryStateInitial extends RecoveryState {
  const RecoveryStateInitial();

  @override
  List<Object?> get props => const [];
}

final class RecoveryStateEmailEntry extends RecoveryState {
  const RecoveryStateEmailEntry({required this.flowId});

  final String flowId;

  @override
  List<Object?> get props => [flowId];
}

final class RecoveryStatePinEntry extends RecoveryState {
  const RecoveryStatePinEntry({required this.flowId});

  final String flowId;

  @override
  List<Object?> get props => [flowId];
}

final class RecoveryStateFlowPinResult extends RecoveryState {
  const RecoveryStateFlowPinResult({required this.flow});

  final SettingsFlowResultData flow;

  @override
  List<Object?> get props => [flow];
}

final class RecoveryStateLoading extends RecoveryState {
  const RecoveryStateLoading();

  @override
  List<Object?> get props => const [];
}

final class RecoveryStateSuccess extends RecoveryState {
  const RecoveryStateSuccess();

  @override
  List<Object?> get props => const [];
}

final class RecoveryStateFlowError extends RecoveryState {
  const RecoveryStateFlowError();

  @override
  List<Object?> get props => const [];
}

enum RecoveryEvent { success, error }

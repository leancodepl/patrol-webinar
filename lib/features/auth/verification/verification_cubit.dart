import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:leancode_forms/leancode_forms.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class VerificationCubit extends Cubit<VerificationState>
    with BlocPresentationMixin<VerificationState, VerificationEvent> {
  VerificationCubit({
    required this.kratosClient,
    required this.email,
    required this.initialFlowId,
  }) : super(const VerificationStateLoading());

  final KratosClient kratosClient;
  final String? initialFlowId;
  final String? email;
  final code = TextFieldCubit<ValidationError>(
    validator: filled(
      const LocalValidationError(LocalValidationErrorType.empty),
    ),
  );

  Future<void> init() async {
    if (state is! VerificationStateLoading) {
      emit(const VerificationStateLoading());
    }

    if (initialFlowId case final String id) {
      emit(VerificationStateReady(flowId: id));
    } else if (email case final String email) {
      final flow = await kratosClient.getNewVerificationFlow(email);

      if (flow != null) {
        emit(VerificationStateReady(flowId: flow.id));
      } else {
        emit(const VerificationStateInitError(retriable: true));
      }
    } else {
      emit(const VerificationStateInitError(retriable: false));
    }
  }

  Future<void> verify({required String code}) async {
    if (!this.code.validate()) {
      return;
    }

    var currentState = state;

    if (currentState is! VerificationStateReady) {
      emitPresentation(VerificationEvent.errorVerification);
      return;
    }

    final flowId = currentState.flowId;

    if (flowId == null) {
      emitPresentation(VerificationEvent.errorVerification);
      return;
    }

    emit(currentState = VerificationStateInProgress(flowId: flowId));

    final result = await kratosClient.verifyAccount(flowId: flowId, code: code);

    switch (result) {
      case VerificationSuccessResult():
        emitPresentation(VerificationEvent.successVerification);
      case VerificationErrorResult():
        emitPresentation(VerificationEvent.errorVerification);
        emit(currentState = VerificationStateReady(flowId: flowId));
      case VerificationUnknownErrorResult():
        emitPresentation(VerificationEvent.errorVerification);
        emit(currentState = VerificationStateReady(flowId: flowId));
      case VerificationFlowExpiredResult():
        emit(const VerificationStateExpired());
    }
  }

  Future<void> getNewVerificationFlow() async {
    final currentState = state;

    if (currentState is! VerificationStateReady) {
      emitPresentation(VerificationEvent.errorVerification);
      return;
    }

    if (email case final String email) {
      final flow = await kratosClient.getNewVerificationFlow(email);

      if (flow != null) {
        emitPresentation(VerificationEvent.successSend);

        emit(VerificationStateReady(flowId: flow.id));
      } else {
        emitPresentation(VerificationEvent.errorSend);
      }
    }
  }
}

sealed class VerificationState with EquatableMixin {
  const VerificationState();

  bool get inProgress => switch (this) {
    VerificationStateLoading() || VerificationStateInProgress() => true,
    VerificationStateReady() ||
    VerificationStateInitError() ||
    VerificationStateExpired() => false,
  };
}

final class VerificationStateLoading extends VerificationState {
  const VerificationStateLoading();

  @override
  List<Object?> get props => const [];
}

final class VerificationStateReady extends VerificationState {
  const VerificationStateReady({this.flowId});

  final String? flowId;

  @override
  List<Object?> get props => [flowId];
}

final class VerificationStateInProgress extends VerificationState {
  const VerificationStateInProgress({this.flowId});

  final String? flowId;

  @override
  List<Object?> get props => [flowId];
}

final class VerificationStateInitError extends VerificationState {
  const VerificationStateInitError({required this.retriable});

  final bool retriable;

  @override
  List<Object?> get props => [retriable];
}

final class VerificationStateExpired extends VerificationState {
  const VerificationStateExpired();

  @override
  List<Object?> get props => const [];
}

enum VerificationEvent {
  successSend,
  errorSend,
  successVerification,
  errorVerification,
}

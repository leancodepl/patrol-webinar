import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

part 'passkey_management_cubit.g.dart';

class PasskeyManagementCubit extends Cubit<PasskeyManagementState>
    with BlocPresentationMixin<PasskeyManagementState, PasskeyManagementEvent> {
  PasskeyManagementCubit({
    required this.kratosClient,
    required this.passkeyCredentialManager,
  }) : super(const PasskeyManagementState(isLoading: true));

  final KratosClient kratosClient;
  final PasskeyCredentialManager passkeyCredentialManager;

  Future<void> init() async {
    await _loadPasskeys();
  }

  Future<void> addPasskey() async {
    if (state.isUpdating) {
      return;
    }

    emit(state.copyWith(isUpdating: true));
    final result = await kratosClient.addPasskey(
      passkeyCallback: _credentialCreationCallback,
    );

    switch (result) {
      case AddPasskeySuccessResult():
        emitPresentation(PasskeyManagementEvent.additionSuccess);
        await _loadPasskeys(silent: true);
      case AddPasskeyCancelledResult():
        emit(state.asUpdated());
      case AddPasskeyReauthenticationRequiredResult():
        emitPresentation(PasskeyManagementEvent.reauthenticationRequired);
      case AddPasskeyErrorResult():
        emitPresentation(PasskeyManagementEvent.additionError);
    }

    emit(state.asUpdated());
  }

  Future<void> removePasskey(String passkeyId) async {
    if (state.isUpdating) {
      return;
    }

    if (state.passkeys.isEmpty) {
      return;
    }

    emit(state.asUpdating());

    final result = await kratosClient.removePasskey(passkeyId: passkeyId);

    switch (result) {
      case RemovePasskeySuccessResult():
        emitPresentation(PasskeyManagementEvent.removalSuccess);
        await _loadPasskeys(silent: true);
      case RemovePasskeyReauthenticationRequiredResult():
        emitPresentation(PasskeyManagementEvent.reauthenticationRequired);
      case RemovePasskeyErrorResult():
        emitPresentation(PasskeyManagementEvent.removalError);
    }

    emit(state.asUpdated());
  }

  Future<void> _loadPasskeys({bool silent = false}) async {
    if (!silent) {
      emit(state.asLoading());
    }

    final passkeysResult = await kratosClient.getPasskeys();

    switch (passkeysResult) {
      case GetPasskeysSuccessResult(:final passkeys):
        emit(state.asLoaded(passkeys));
      case GetPasskeysErrorResult():
        if (!silent) {
          emit(state.asError(const PasskeyLoadingError()));
        }
    }
  }

  Future<PasskeyCallbackResult> _credentialCreationCallback(
    Map<String, dynamic> options,
  ) async {
    final result = await passkeyCredentialManager.create(options);

    return switch (result) {
      PasskeyCreationSuccess(:final publicKeyJson) =>
        PasskeyCallbackSuccessResult(publicKeyJson),
      PasskeyCreationCancelled() => const PasskeyCallbackCancelledResult(),
      PasskeyCreationFailure() => const PasskeyCallbackErrorResult(),
    };
  }
}

@CopyWith()
final class PasskeyManagementState with EquatableMixin {
  const PasskeyManagementState({
    this.passkeys = const [],
    this.isLoading = false,
    this.isUpdating = false,
    this.error,
  });

  final List<Passkey> passkeys;
  final bool isLoading;
  final bool isUpdating;
  final PasskeyManagementError? error;

  PasskeyManagementState asLoading() => copyWith(isLoading: true);

  PasskeyManagementState asUpdating() => copyWith(isUpdating: true);

  PasskeyManagementState asLoaded(List<Passkey> passkeys) =>
      copyWith(passkeys: passkeys, isLoading: false);

  PasskeyManagementState asUpdated() => copyWith(isUpdating: false);

  PasskeyManagementState asError(PasskeyManagementError error) =>
      copyWith(isLoading: false, error: error);

  @override
  List<Object?> get props => [passkeys, isLoading, isUpdating, error];
}

sealed class PasskeyManagementError {
  const PasskeyManagementError();
}

final class PasskeyLoadingError extends PasskeyManagementError {
  const PasskeyLoadingError();
}

enum PasskeyManagementEvent {
  additionSuccess,
  removalSuccess,
  reauthenticationRequired,
  additionError,
  removalError,
}

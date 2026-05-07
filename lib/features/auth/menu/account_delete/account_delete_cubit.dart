import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:cqrs/cqrs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/data/contracts/contracts.dart';

class AccountDeleteCubit extends Cubit<AccountDeleteState>
    with BlocPresentationMixin<AccountDeleteState, AccountDeleteEvent> {
  AccountDeleteCubit({required this.cqrs}) : super(AccountDeleteState.initial);

  final Cqrs cqrs;

  Future<void> deleteAccount() async {
    emit(AccountDeleteState.inProgress);
    final result = await cqrs.run(DeleteOwnAccount());
    if (result.isSuccess) {
      emitPresentation(AccountDeleteEvent.success);
      emit(AccountDeleteState.success);
    } else {
      emitPresentation(AccountDeleteEvent.error);
    }
  }
}

enum AccountDeleteState { initial, inProgress, success }

enum AccountDeleteEvent { success, error }

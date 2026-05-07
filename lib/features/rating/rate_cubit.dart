import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:cqrs/cqrs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/data/contracts/contracts.dart';

class RateCubit extends Cubit<RateState>
    with BlocPresentationMixin<RateState, RateEvent> {
  RateCubit({required this.cqrs}) : super(RateState.initial);

  static const maxRating = 5;

  final Cqrs cqrs;

  Future<void> rateSession({
    required String sessionId,
    required int rating,
    String? comment,
  }) async {
    if (state == RateState.loading) {
      return;
    }

    emit(RateState.loading);
    final result = await cqrs.run(
      RateSession(sessionId: sessionId, rating: rating, comment: comment),
    );
    if (result.isSuccess) {
      emitPresentation(RateEvent.success);
      emit(RateState.success);
    } else {
      emitPresentation(RateEvent.error);
      emit(RateState.error);
    }
  }
}

enum RateState { initial, loading, success, error }

enum RateEvent { success, error }

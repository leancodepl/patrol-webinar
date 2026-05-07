import 'dart:async';

import 'package:cached_query/cached_query.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/auth/user/user_repository.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit({
    required this.userRepository,
    required this.flutterSecureCredentialsStorage,
  }) : super(const MenuStateLoading());

  final UserRepository userRepository;
  final FlutterSecureCredentialsStorage flutterSecureCredentialsStorage;
  StreamSubscription<QueryState<UserProfile>>? _userSubscription;

  void init() {
    _userSubscription = userRepository.query.stream.listen((state) async {
      final kratosToken = await flutterSecureCredentialsStorage.read();
      if (kratosToken == null) {
        emit(const MenuStateUnauthenticated());
        return;
      }

      switch (state) {
        case QuerySuccess(data: final profile):
          if (profile is! UserProfileData) {
            emit(const MenuStateError());
            return;
          }
          emit(MenuStateLoaded(traits: profile.traits, userId: profile.userId));
        case QueryLoading() || QueryInitial():
          emit(const MenuStateLoading());
        case QueryError():
          emit(const MenuStateError());
      }
    });
  }

  @override
  Future<void> close() async {
    await _userSubscription?.cancel();
    await super.close();
  }

  Future<void> refresh() async {
    await userRepository.query.refetch();
  }
}

sealed class MenuState with EquatableMixin {
  const MenuState();
}

final class MenuStateLoading extends MenuState {
  const MenuStateLoading();

  @override
  List<Object?> get props => const [];
}

final class MenuStateUnauthenticated extends MenuState {
  const MenuStateUnauthenticated();

  @override
  List<Object?> get props => const [];
}

final class MenuStateLoaded extends MenuState {
  const MenuStateLoaded({required this.traits, required this.userId});

  final List<ProfileTrait> traits;
  final String userId;

  @override
  List<Object?> get props => [traits, userId];
}

final class MenuStateError extends MenuState {
  const MenuStateError();

  @override
  List<Object?> get props => const [];
}

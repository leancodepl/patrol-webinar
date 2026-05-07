import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.storage, required this.kratosClient})
    : super(const AuthStateInitial());

  final FlutterSecureCredentialsStorage storage;
  final KratosClient kratosClient;

  Future<void> init() async {
    if (state is! AuthStateInitial) {
      return;
    }

    final result = await kratosClient.isSessionValid();

    if (result is! SessionValiditySuccessResult || !result.isValid) {
      await storage.clear();
      emit(const AuthStateUnauthorized());
      return;
    }

    await kratosClient.refreshSessionToken();

    emit(switch (await kratosClient.isSessionValid()) {
      SessionValiditySuccessResult(:final isValid) =>
        isValid ? const AuthStateLoggedIn() : const AuthStateUnauthorized(),
      _ => const AuthStateUnauthorized(),
    });
  }

  Future<void> logout({bool accountRemoved = false}) async {
    if (accountRemoved) {
      await storage.clear();
    } else {
      await kratosClient.logout();
    }

    emit(AuthStateUnauthorized(accountRemoved: accountRemoved));
  }
}

sealed class AuthState with EquatableMixin {
  const AuthState();
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object?> get props => const [];
}

final class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn();

  @override
  List<Object?> get props => const [];
}

final class AuthStateUnauthorized extends AuthState {
  const AuthStateUnauthorized({this.accountRemoved = false});

  final bool accountRemoved;

  @override
  List<Object?> get props => [accountRemoved];
}

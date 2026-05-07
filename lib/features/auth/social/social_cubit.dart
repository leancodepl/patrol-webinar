import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:fts/common/form_cubits/validation_errors.dart';
import 'package:fts/common/util/let.dart';
import 'package:fts/features/app_lifecycle/app_lifecycle_provider.dart';
import 'package:fts/features/auth/common/get_trait_error.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/auth/kratos/common/trait.dart';
import 'package:fts/features/auth/social/social_traits_form_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';
import 'package:logging/logging.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'social_cubit.g.dart';

class SocialCubit extends Cubit<SocialState>
    with BlocPresentationMixin<SocialState, SocialEvent> {
  SocialCubit({
    required this.appLifecycleProvider,
    required this.kratosClient,
    required this.authCubit,
  }) : super(const SocialStateIdle());

  static final _logger = Logger('SocialCubit');

  final AppLifecycleProvider appLifecycleProvider;
  final KratosClient kratosClient;
  final AuthCubit authCubit;

  final formCubit = SocialTraitsFormCubit();

  StreamSubscription<AppLifecycleStateRecord>? _appLifecycleSubscription;

  void init() {
    _appLifecycleSubscription = appLifecycleProvider.stream.listen(
      _onAppLifecycleChange,
    );
  }

  Future<void> registerWithOidc(OidcProvider provider) async {
    final currentState = state;

    if (currentState.inProgress) {
      return;
    }

    emit(switch (currentState) {
      SocialStateIdle() => currentState.copyWith(inProgress: true),
      SocialStateTraitsStep() => currentState.copyWith(inProgress: true),
    });

    final result = await kratosClient.registerWithOidc(
      provider: provider,
      returnTo: 'pl.leancode.fts.tst://app',
      browserCallback: _browserCallback,
      appleSdkCallback: _appleSdkCallback,
      googleSdkCallback: _googleSdkCallback,
    );

    _handleResponse(result, provider);
  }

  Future<void> finishRegisterWithOidc() async {
    if (!formCubit.validate()) {
      return;
    }

    var currentState = state;

    if (currentState is! SocialStateTraitsStep) {
      return;
    }

    emit(currentState = currentState.copyWith(inProgress: true));

    final result = await kratosClient.registerWithOidc(
      provider: currentState.provider,
      returnTo: 'pl.leancode.fts.tst://app',
      browserCallback: _browserCallback,
      appleSdkCallback: _appleSdkCallback,
      googleSdkCallback: _googleSdkCallback,
      flowInfo: currentState.flowInfo,
      idToken: currentState.idToken,
      traits: {
        Trait.email.key: formCubit.email.state.value,
        Trait.givenName.key: formCubit.firstName.state.value,
        Trait.familyName.key: formCubit.lastName.state.value,
        Trait.regulationsAccepted.key: formCubit.checkbox.state.value,
      },
    );

    _handleResponse(result, currentState.provider);
  }

  void _handleResponse(RegistrationResult result, OidcProvider provider) {
    switch (result) {
      case RegistrationVerifyEmailResult():
        emitPresentation(
          SocialEventVerifyEmail(
            email: result.emailToVerify,
            flowId: result.flowId,
          ),
        );
      case RegistrationSuccessResult():
        authCubit.emit(const AuthStateLoggedIn());
        emitPresentation(const SocialEventSuccess());
      case RegistrationLinkAccountResult():
        emitPresentation(const SocialEventAccountExists());
        emit(const SocialStateIdle());
      case RegistrationSocialFinishResult():
        formCubit.setInitialValues(
          emailValue: _getTraitValue(Trait.email, result.values) as String?,
          firstNameValue:
              _getTraitValue(Trait.givenName, result.values) as String?,
          lastNameValue:
              _getTraitValue(Trait.familyName, result.values) as String?,
          regulationsAccepted:
              _getTraitValue(Trait.regulationsAccepted, result.values) as bool?,
        );
        emit(
          SocialStateTraitsStep(
            provider: provider,
            flowInfo: result.flowInfo,
            idToken: result.idToken,
          ),
        );
      case RegistrationCancelledResult():
        emit(state.commonCopyWith(inProgress: false));
      case RegistrationErrorResult():
        _setErrors(result.fieldErrors);

        emit(
          state.commonCopyWith(
            generalError: result.generalErrors.firstOrNull?.let(
              SocialKratosGeneralError.new,
            ),
            inProgress: false,
          ),
        );
      case RegistrationUnknownErrorResult():
        emit(
          state.commonCopyWith(
            generalError: const SocialUnknownError(),
            inProgress: false,
          ),
        );
    }
  }

  Future<String> _browserCallback(String url) {
    return FlutterWebAuth2.authenticate(
      url: url,
      callbackUrlScheme: 'pl.leancode.fts.tst',
    );
  }

  Future<SdkResult> _appleSdkCallback() async {
    AuthorizationCredentialAppleID credential;

    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } on SignInWithAppleAuthorizationException catch (err, st) {
      if (err.code == AuthorizationErrorCode.canceled) {
        return const SdkCancelledResult();
      }

      _logger.severe('Failed to authenticated with apple', err, st);

      return const SdkErrorResult();
    } catch (err, st) {
      _logger.severe('Failed to authenticated with apple', err, st);

      return const SdkErrorResult();
    }

    final AuthorizationCredentialAppleID(
      identityToken: idToken,
      :givenName,
      :familyName,
    ) = credential;

    if (idToken == null) {
      return const SdkErrorResult();
    }

    final decodedToken = JwtDecoder.decode(idToken);
    final email = decodedToken['email'];

    return SdkSuccessResult(
      idToken: idToken,
      traits: {
        Trait.email.key: ?email,
        Trait.givenName.key: ?givenName,
        Trait.familyName.key: ?familyName,
      },
    );
  }

  Future<SdkResult> _googleSdkCallback() async {
    final googleSignIn = GoogleSignIn.instance;

    GoogleSignInAccount? account;

    try {
      await googleSignIn.signOut();
      account = await googleSignIn.authenticate(scopeHint: ['email']);
    } catch (err, st) {
      _logger.severe('Failed to authenticated with google', err, st);

      return const SdkErrorResult();
    }

    final authentication = account.authentication;

    final idToken = authentication.idToken;

    if (idToken == null) {
      return const SdkErrorResult();
    }

    final email = account.email;
    final decodedToken = JwtDecoder.decode(idToken);
    final givenName = decodedToken['given_name'];
    final familyName = decodedToken['family_name'];

    return SdkSuccessResult(
      idToken: idToken,
      traits: {
        Trait.email.key: email,
        Trait.givenName.key: ?givenName,
        Trait.familyName.key: ?familyName,
      },
    );
  }

  void _setErrors(List<(String, KratosMessage)> fieldErrors) {
    getTraitError(
      fieldErrors,
      Trait.email,
    )?.let((error) => formCubit.email.setError(KratosValidationError(error)));
    getTraitError(fieldErrors, Trait.givenName)?.let(
      (error) => formCubit.firstName.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.familyName)?.let(
      (error) => formCubit.lastName.setError(KratosValidationError(error)),
    );
    getTraitError(fieldErrors, Trait.regulationsAccepted)?.let(
      (error) => formCubit.checkbox.setError(KratosValidationError(error)),
    );
  }

  dynamic _getTraitValue(Trait trait, List<(String, dynamic)> values) {
    return values
        .firstWhereOrNull((value) => value.$1 == 'traits.${trait.key}')
        ?.$2;
  }

  void _onAppLifecycleChange(AppLifecycleStateRecord stateRecord) {
    if (state.inProgress && stateRecord.current == AppLifecycleState.resumed) {
      emit(switch (state) {
        final SocialStateIdle idle => idle.copyWith(
          generalError: const SocialUnknownError(),
          inProgress: false,
        ),
        final SocialStateTraitsStep traitsStep => traitsStep.copyWith(
          generalError: const SocialUnknownError(),
          inProgress: false,
        ),
      });
    }
  }

  void cancel() {
    if (state.inProgress) {
      return;
    }

    emit(const SocialStateIdle());
  }

  @override
  Future<void> close() async {
    await _appLifecycleSubscription?.cancel();
    await formCubit.close();
    return super.close();
  }
}

sealed class SocialState with EquatableMixin {
  const SocialState({
    this.inProgress = false,
    this.flowInfo,
    this.generalError,
  });

  final bool inProgress;
  final AuthFlowInfo? flowInfo;
  final SocialGeneralError? generalError;

  SocialState Function({
    AuthFlowInfo? flowInfo,
    SocialGeneralError? generalError,
    bool inProgress,
  })
  get commonCopyWith => switch (this) {
    final SocialStateIdle state => state.copyWith.call,
    final SocialStateTraitsStep state => state.copyWith.call,
  };

  @override
  List<Object?> get props => [inProgress, flowInfo, generalError];
}

@CopyWith()
final class SocialStateIdle extends SocialState {
  const SocialStateIdle({super.inProgress, super.flowInfo, super.generalError});
}

@CopyWith()
final class SocialStateTraitsStep extends SocialState {
  const SocialStateTraitsStep({
    super.inProgress,
    super.flowInfo,
    super.generalError,
    required this.provider,
    this.idToken,
  });

  final OidcProvider provider;
  final String? idToken;

  @override
  List<Object?> get props => [super.props, provider, idToken];
}

sealed class SocialGeneralError {
  const SocialGeneralError();
}

class SocialUnknownError extends SocialGeneralError {
  const SocialUnknownError();
}

class SocialKratosGeneralError extends SocialGeneralError {
  const SocialKratosGeneralError(this.error);

  final KratosMessage error;
}

sealed class SocialEvent {
  const SocialEvent();
}

final class SocialEventSuccess extends SocialEvent {
  const SocialEventSuccess();
}

final class SocialEventVerifyEmail extends SocialEvent {
  const SocialEventVerifyEmail({required this.email, required this.flowId});

  final String? email;
  final String? flowId;
}

final class SocialEventAccountExists extends SocialEvent {
  const SocialEventAccountExists();
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:logging/logging.dart';
import 'package:passkeys/authenticator.dart';
import 'package:passkeys/types.dart';

class PasskeyCredentialManagerImpl implements PasskeyCredentialManager {
  PasskeyCredentialManagerImpl({required PasskeyAuthenticator authenticator})
    : _authenticator = authenticator;

  final PasskeyAuthenticator _authenticator;

  static final _logger = Logger('PasskeyCredentialManagerImpl');

  @override
  Future<bool> checkAvailability() async {
    try {
      final availability = _authenticator.getAvailability();

      final platformAvailability = switch (defaultTargetPlatform) {
        _ when kIsWeb => await availability.web(),
        TargetPlatform.android => await availability.android(),
        TargetPlatform.iOS => await availability.iOS(),
        _ => null,
      };

      return platformAvailability?.hasPasskeySupport ?? false;
    } catch (err, st) {
      _logger.severe('Failed to check availability', err, st);
      return false;
    }
  }

  @override
  Future<PasskeyCreationResult> create(Map<String, dynamic> options) async {
    try {
      final request = _RegisterRequestTypeExtension.fromOptions(options);

      final response = await _authenticator.register(request);

      return PasskeyCreationSuccess(json.encode(response.toCredentialJson()));
    } on PasskeyAuthCancelledException {
      _logger.info('Cancelled credential creation');
      return const PasskeyCreationCancelled();
    } catch (err, st) {
      _logger.severe('Failed to create credential', err, st);
      return const PasskeyCreationFailure();
    }
  }

  @override
  Future<PasskeyRequestResult> request(Map<String, dynamic> options) async {
    try {
      final request = _AuthenticateRequestTypeExtension.fromOptions(options);

      final response = await _authenticator.authenticate(request);

      return PasskeyRequestSuccess(json.encode(response.toCredentialJson()));
    } on PasskeyAuthCancelledException {
      _logger.info('Cancelled credential request');
      return const PasskeyRequestCancelled();
    } on NoCredentialsAvailableException {
      _logger.info('No credentials available');
      return const PasskeyRequestNoCredentialsAvailable();
    } catch (err, st) {
      _logger.severe('Failed to request credential', err, st);
      return const PasskeyRequestFailure();
    }
  }
}

extension _RegisterRequestTypeExtension on RegisterRequestType {
  static RegisterRequestType fromOptions(Map<String, dynamic> json) {
    return RegisterRequestType(
      challenge: json['challenge']! as String,
      relyingParty: RelyingPartyType.fromJson((json['rp']! as Map).cast()),
      user: UserType.fromJson((json['user']! as Map).cast()),
      authSelectionType: AuthenticatorSelectionType.fromJson(
        (json['authenticatorSelection']! as Map).cast(),
      ),
      excludeCredentials:
          (json['excludeCredentials'] as List?)
              ?.map((e) => CredentialType.fromJson((e as Map).cast()))
              .toList() ??
          [],
      timeout: json['timeout']! as int?,
      attestation: json['attestation'] as String?,
      pubKeyCredParams: (json['pubKeyCredParams'] as List?)
          ?.map((e) => PubKeyCredParamType.fromJson((e as Map).cast()))
          .toList(),
    );
  }
}

extension on RegisterResponseType {
  Map<String, dynamic> toCredentialJson() {
    return {
      'id': id,
      'rawId': rawId,
      'type': 'public-key',
      'response': {
        'attestationObject': attestationObject,
        'clientDataJSON': clientDataJSON,
        'transports': transports,
      },
    };
  }
}

extension _AuthenticateRequestTypeExtension on AuthenticateResponseType {
  static AuthenticateRequestType fromOptions(Map<String, dynamic> json) {
    return AuthenticateRequestType(
      relyingPartyId: json['rpId']! as String,
      challenge: json['challenge']! as String,
      timeout: json['timeout'] as int?,
      userVerification: json['userVerification'] as String?,
      mediation: MediationType.Optional,
      preferImmediatelyAvailableCredentials: true,
    );
  }
}

extension on AuthenticateResponseType {
  Map<String, dynamic> toCredentialJson() {
    return {
      'id': id,
      'rawId': rawId,
      'type': 'public-key',
      'response': {
        'clientDataJSON': clientDataJSON,
        'authenticatorData': authenticatorData,
        'signature': signature,
        'userHandle': userHandle,
      },
    };
  }
}

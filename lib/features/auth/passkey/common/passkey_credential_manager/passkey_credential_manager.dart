abstract interface class PasskeyCredentialManager {
  Future<bool> checkAvailability();

  /// Creates a new credential
  /// Expects a public key creation options
  /// Returns a public key credential as a json string
  /// Seehttps://webauthn.guide/#registration for more info
  Future<PasskeyCreationResult> create(Map<String, dynamic> options);

  /// Requests an existing credential
  /// Expects a public key request options
  /// Returns a public key credential as a json string
  /// See https://webauthn.guide/#authentication for more info
  Future<PasskeyRequestResult> request(Map<String, dynamic> options);
}

sealed class PasskeyCreationResult {
  const PasskeyCreationResult();
}

final class PasskeyCreationSuccess extends PasskeyCreationResult {
  const PasskeyCreationSuccess(this.publicKeyJson);

  final String publicKeyJson;
}

final class PasskeyCreationFailure extends PasskeyCreationResult {
  const PasskeyCreationFailure();
}

final class PasskeyCreationCancelled extends PasskeyCreationResult {
  const PasskeyCreationCancelled();
}

sealed class PasskeyRequestResult {
  const PasskeyRequestResult();
}

final class PasskeyRequestSuccess extends PasskeyRequestResult {
  const PasskeyRequestSuccess(this.publicKeyJson);

  final String publicKeyJson;
}

final class PasskeyRequestFailure extends PasskeyRequestResult {
  const PasskeyRequestFailure();
}

final class PasskeyRequestCancelled extends PasskeyRequestResult {
  const PasskeyRequestCancelled();
}

final class PasskeyRequestNoCredentialsAvailable extends PasskeyRequestResult {
  const PasskeyRequestNoCredentialsAvailable();
}

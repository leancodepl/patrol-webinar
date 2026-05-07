import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';

class PasskeyCredentialManagerUnavailable implements PasskeyCredentialManager {
  @override
  Future<bool> checkAvailability() async {
    return false;
  }

  @override
  Future<PasskeyCreationResult> create(Map<String, dynamic> options) {
    throw UnimplementedError('Passkeys are not available');
  }

  @override
  Future<PasskeyRequestResult> request(Map<String, dynamic> options) {
    throw UnimplementedError('Passkeys are not available');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class MailboxClientProxy {
  static const domain = 'inbox.testmail.app';
  static const namespace = '61dtq';

  static const apiKey = String.fromEnvironment('MAILBOX_API_KEY');

  String generateRandomUsername() {
    return 'user-${DateTime.now().millisecondsSinceEpoch}';
  }

  String getEmail(String username) {
    return '$namespace.$username@$domain';
  }

  Future<String> getActivationCode(String username) async {
    final queryParameters = <String, dynamic>{
      'apikey': apiKey,
      'namespace': namespace,
      'livequery': 'true',
      'tag': username,
    };

    final response = await http.get(_getUri(queryParameters));

    if (response.statusCode != 200) {
      throw Exception(
        'Getting activation code failed - ${response.statusCode}\n'
        '${_getUri(queryParameters).queryParameters} - ${_getUri(queryParameters).path}',
      );
    }

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    final emails = responseBody['emails'] as List<dynamic>;
    final email = emails.first as Map<String, dynamic>;
    final html = email['html'] as String;

    final regExpFirstMatch = RegExp(r'(\d{6})').firstMatch(html);
    if (regExpFirstMatch != null) {
      return regExpFirstMatch.group(0)!;
    } else {
      throw Exception('No six-digit code found in subject');
    }
  }

  Uri _getUri(Map<String, dynamic> queryParameters) {
    final uri = Uri(
      scheme: 'https',
      host: 'api.testmail.app',
      path: 'api/json',
      queryParameters: queryParameters,
    );
    return uri;
  }
}

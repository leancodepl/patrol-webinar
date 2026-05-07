import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/env_variables.dart';

class MailpitClient {
  static const _credentials = '${V.mailpitLogin}:${V.mailpitPassword}';
  final _headers = {
    'Authorization': 'Basic ${base64Encode(utf8.encode(_credentials))}',
  };

  String generateRandomEmailAddress() {
    return 'user-${DateTime.now().millisecondsSinceEpoch}@fts.test.lncd.pl';
  }

  Future<String> getActivationCode() async {
    final response = await _get('/message/latest');

    if (response.statusCode != 200) {
      throw Exception(
        'Getting activation code failed - ${response.statusCode}\n',
      );
    }

    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    final emailBody = responseBody['Text']! as String;

    final regExpFirstMatch = RegExp(r'(\d{6})').firstMatch(emailBody);
    if (regExpFirstMatch != null) {
      return regExpFirstMatch.group(0)!;
    } else {
      throw Exception('No six-digit code found in subject');
    }
  }

  Future<http.Response> _get(String path) =>
      http.get(_constructUri(path), headers: _headers);

  Uri _constructUri(String path, {Map<String, dynamic>? queryParameters}) =>
      Uri(
        scheme: 'https',
        host: 'mailpit.internal.lncd.pl',
        path: '/api/v1/$path',
        queryParameters: queryParameters,
      );
}

import 'package:collection/collection.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

KratosMessage? getFieldError(
  List<(String, KratosMessage)> fieldErrors,
  String field,
) {
  return fieldErrors.firstWhereOrNull((error) => error.$1 == field)?.$2;
}

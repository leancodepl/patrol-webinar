import 'package:fts/features/auth/common/get_field_error.dart';
import 'package:fts/features/auth/kratos/common/trait.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

KratosMessage? getTraitError(
  List<(String, KratosMessage)> fieldErrors,
  Trait trait,
) {
  return getFieldError(fieldErrors, 'traits.${trait.name}');
}

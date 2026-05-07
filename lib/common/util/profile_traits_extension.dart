import 'package:collection/collection.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

extension ProfileTraitsExtension on List<ProfileTrait> {
  String? _getTrait(String traitName) {
    return firstWhereOrNull((trait) => trait.traitName == traitName)?.value
        as String?;
  }

  String? get givenName {
    return _getTrait('given_name');
  }

  String? get familyName {
    return _getTrait('family_name');
  }

  String? get email {
    return _getTrait('email');
  }

  String get initials {
    return (givenName?[0] ?? '') + (familyName?[0] ?? '');
  }
}

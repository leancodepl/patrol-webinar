// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passkey_management_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PasskeyManagementStateCWProxy {
  PasskeyManagementState passkeys(List<Passkey> passkeys);

  PasskeyManagementState isLoading(bool isLoading);

  PasskeyManagementState isUpdating(bool isUpdating);

  PasskeyManagementState error(PasskeyManagementError? error);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PasskeyManagementState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PasskeyManagementState(...).copyWith(id: 12, name: "My name")
  /// ```
  PasskeyManagementState call({
    List<Passkey> passkeys,
    bool isLoading,
    bool isUpdating,
    PasskeyManagementError? error,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPasskeyManagementState.copyWith(...)` or call `instanceOfPasskeyManagementState.copyWith.fieldName(value)` for a single field.
class _$PasskeyManagementStateCWProxyImpl
    implements _$PasskeyManagementStateCWProxy {
  const _$PasskeyManagementStateCWProxyImpl(this._value);

  final PasskeyManagementState _value;

  @override
  PasskeyManagementState passkeys(List<Passkey> passkeys) =>
      call(passkeys: passkeys);

  @override
  PasskeyManagementState isLoading(bool isLoading) =>
      call(isLoading: isLoading);

  @override
  PasskeyManagementState isUpdating(bool isUpdating) =>
      call(isUpdating: isUpdating);

  @override
  PasskeyManagementState error(PasskeyManagementError? error) =>
      call(error: error);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PasskeyManagementState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PasskeyManagementState(...).copyWith(id: 12, name: "My name")
  /// ```
  PasskeyManagementState call({
    Object? passkeys = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isUpdating = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return PasskeyManagementState(
      passkeys: passkeys == const $CopyWithPlaceholder() || passkeys == null
          ? _value.passkeys
          // ignore: cast_nullable_to_non_nullable
          : passkeys as List<Passkey>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isUpdating:
          isUpdating == const $CopyWithPlaceholder() || isUpdating == null
          ? _value.isUpdating
          // ignore: cast_nullable_to_non_nullable
          : isUpdating as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as PasskeyManagementError?,
    );
  }
}

extension $PasskeyManagementStateCopyWith on PasskeyManagementState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPasskeyManagementState.copyWith(...)` or `instanceOfPasskeyManagementState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PasskeyManagementStateCWProxy get copyWith =>
      _$PasskeyManagementStateCWProxyImpl(this);
}

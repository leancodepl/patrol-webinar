// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterStateProfileEnterCWProxy {
  RegisterStateProfileEnter inProgress(bool inProgress);

  RegisterStateProfileEnter generalError(RegisterGeneralError? generalError);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RegisterStateProfileEnter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RegisterStateProfileEnter(...).copyWith(id: 12, name: "My name")
  /// ```
  RegisterStateProfileEnter call({
    bool inProgress,
    RegisterGeneralError? generalError,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRegisterStateProfileEnter.copyWith(...)` or call `instanceOfRegisterStateProfileEnter.copyWith.fieldName(value)` for a single field.
class _$RegisterStateProfileEnterCWProxyImpl
    implements _$RegisterStateProfileEnterCWProxy {
  const _$RegisterStateProfileEnterCWProxyImpl(this._value);

  final RegisterStateProfileEnter _value;

  @override
  RegisterStateProfileEnter inProgress(bool inProgress) =>
      call(inProgress: inProgress);

  @override
  RegisterStateProfileEnter generalError(RegisterGeneralError? generalError) =>
      call(generalError: generalError);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RegisterStateProfileEnter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RegisterStateProfileEnter(...).copyWith(id: 12, name: "My name")
  /// ```
  RegisterStateProfileEnter call({
    Object? inProgress = const $CopyWithPlaceholder(),
    Object? generalError = const $CopyWithPlaceholder(),
  }) {
    return RegisterStateProfileEnter(
      inProgress:
          inProgress == const $CopyWithPlaceholder() || inProgress == null
          ? _value.inProgress
          // ignore: cast_nullable_to_non_nullable
          : inProgress as bool,
      generalError: generalError == const $CopyWithPlaceholder()
          ? _value.generalError
          // ignore: cast_nullable_to_non_nullable
          : generalError as RegisterGeneralError?,
    );
  }
}

extension $RegisterStateProfileEnterCopyWith on RegisterStateProfileEnter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRegisterStateProfileEnter.copyWith(...)` or `instanceOfRegisterStateProfileEnter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterStateProfileEnterCWProxy get copyWith =>
      _$RegisterStateProfileEnterCWProxyImpl(this);
}

abstract class _$RegisterStatePasswordEnterCWProxy {
  RegisterStatePasswordEnter email(String email);

  RegisterStatePasswordEnter firstName(String firstName);

  RegisterStatePasswordEnter lastName(String lastName);

  RegisterStatePasswordEnter regulationsAccepted(bool regulationsAccepted);

  RegisterStatePasswordEnter flowInfo(AuthFlowInfo flowInfo);

  RegisterStatePasswordEnter inProgress(bool inProgress);

  RegisterStatePasswordEnter generalError(RegisterGeneralError? generalError);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RegisterStatePasswordEnter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RegisterStatePasswordEnter(...).copyWith(id: 12, name: "My name")
  /// ```
  RegisterStatePasswordEnter call({
    String email,
    String firstName,
    String lastName,
    bool regulationsAccepted,
    AuthFlowInfo flowInfo,
    bool inProgress,
    RegisterGeneralError? generalError,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfRegisterStatePasswordEnter.copyWith(...)` or call `instanceOfRegisterStatePasswordEnter.copyWith.fieldName(value)` for a single field.
class _$RegisterStatePasswordEnterCWProxyImpl
    implements _$RegisterStatePasswordEnterCWProxy {
  const _$RegisterStatePasswordEnterCWProxyImpl(this._value);

  final RegisterStatePasswordEnter _value;

  @override
  RegisterStatePasswordEnter email(String email) => call(email: email);

  @override
  RegisterStatePasswordEnter firstName(String firstName) =>
      call(firstName: firstName);

  @override
  RegisterStatePasswordEnter lastName(String lastName) =>
      call(lastName: lastName);

  @override
  RegisterStatePasswordEnter regulationsAccepted(bool regulationsAccepted) =>
      call(regulationsAccepted: regulationsAccepted);

  @override
  RegisterStatePasswordEnter flowInfo(AuthFlowInfo flowInfo) =>
      call(flowInfo: flowInfo);

  @override
  RegisterStatePasswordEnter inProgress(bool inProgress) =>
      call(inProgress: inProgress);

  @override
  RegisterStatePasswordEnter generalError(RegisterGeneralError? generalError) =>
      call(generalError: generalError);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `RegisterStatePasswordEnter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// RegisterStatePasswordEnter(...).copyWith(id: 12, name: "My name")
  /// ```
  RegisterStatePasswordEnter call({
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? regulationsAccepted = const $CopyWithPlaceholder(),
    Object? flowInfo = const $CopyWithPlaceholder(),
    Object? inProgress = const $CopyWithPlaceholder(),
    Object? generalError = const $CopyWithPlaceholder(),
  }) {
    return RegisterStatePasswordEnter(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      regulationsAccepted:
          regulationsAccepted == const $CopyWithPlaceholder() ||
              regulationsAccepted == null
          ? _value.regulationsAccepted
          // ignore: cast_nullable_to_non_nullable
          : regulationsAccepted as bool,
      flowInfo: flowInfo == const $CopyWithPlaceholder() || flowInfo == null
          ? _value.flowInfo
          // ignore: cast_nullable_to_non_nullable
          : flowInfo as AuthFlowInfo,
      inProgress:
          inProgress == const $CopyWithPlaceholder() || inProgress == null
          ? _value.inProgress
          // ignore: cast_nullable_to_non_nullable
          : inProgress as bool,
      generalError: generalError == const $CopyWithPlaceholder()
          ? _value.generalError
          // ignore: cast_nullable_to_non_nullable
          : generalError as RegisterGeneralError?,
    );
  }
}

extension $RegisterStatePasswordEnterCopyWith on RegisterStatePasswordEnter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfRegisterStatePasswordEnter.copyWith(...)` or `instanceOfRegisterStatePasswordEnter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterStatePasswordEnterCWProxy get copyWith =>
      _$RegisterStatePasswordEnterCWProxyImpl(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginStateInitialCWProxy {
  LoginStateInitial flowInfo(AuthFlowInfo? flowInfo);

  LoginStateInitial generalError(LoginGeneralError? generalError);

  LoginStateInitial inProgress(bool inProgress);

  LoginStateInitial email(String? email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LoginStateInitial(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LoginStateInitial(...).copyWith(id: 12, name: "My name")
  /// ```
  LoginStateInitial call({
    AuthFlowInfo? flowInfo,
    LoginGeneralError? generalError,
    bool inProgress,
    String? email,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLoginStateInitial.copyWith(...)` or call `instanceOfLoginStateInitial.copyWith.fieldName(value)` for a single field.
class _$LoginStateInitialCWProxyImpl implements _$LoginStateInitialCWProxy {
  const _$LoginStateInitialCWProxyImpl(this._value);

  final LoginStateInitial _value;

  @override
  LoginStateInitial flowInfo(AuthFlowInfo? flowInfo) =>
      call(flowInfo: flowInfo);

  @override
  LoginStateInitial generalError(LoginGeneralError? generalError) =>
      call(generalError: generalError);

  @override
  LoginStateInitial inProgress(bool inProgress) => call(inProgress: inProgress);

  @override
  LoginStateInitial email(String? email) => call(email: email);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LoginStateInitial(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LoginStateInitial(...).copyWith(id: 12, name: "My name")
  /// ```
  LoginStateInitial call({
    Object? flowInfo = const $CopyWithPlaceholder(),
    Object? generalError = const $CopyWithPlaceholder(),
    Object? inProgress = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return LoginStateInitial(
      flowInfo: flowInfo == const $CopyWithPlaceholder()
          ? _value.flowInfo
          // ignore: cast_nullable_to_non_nullable
          : flowInfo as AuthFlowInfo?,
      generalError: generalError == const $CopyWithPlaceholder()
          ? _value.generalError
          // ignore: cast_nullable_to_non_nullable
          : generalError as LoginGeneralError?,
      inProgress:
          inProgress == const $CopyWithPlaceholder() || inProgress == null
          ? _value.inProgress
          // ignore: cast_nullable_to_non_nullable
          : inProgress as bool,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
    );
  }
}

extension $LoginStateInitialCopyWith on LoginStateInitial {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLoginStateInitial.copyWith(...)` or `instanceOfLoginStateInitial.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginStateInitialCWProxy get copyWith =>
      _$LoginStateInitialCWProxyImpl(this);
}

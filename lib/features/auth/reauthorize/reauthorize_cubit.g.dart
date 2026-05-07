// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reauthorize_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReauthorizeStateCWProxy {
  ReauthorizeState flowInfo(AuthFlowInfo? flowInfo);

  ReauthorizeState generalError(LoginGeneralError? generalError);

  ReauthorizeState inProgress(bool inProgress);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReauthorizeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReauthorizeState(...).copyWith(id: 12, name: "My name")
  /// ```
  ReauthorizeState call({
    AuthFlowInfo? flowInfo,
    LoginGeneralError? generalError,
    bool inProgress,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReauthorizeState.copyWith(...)` or call `instanceOfReauthorizeState.copyWith.fieldName(value)` for a single field.
class _$ReauthorizeStateCWProxyImpl implements _$ReauthorizeStateCWProxy {
  const _$ReauthorizeStateCWProxyImpl(this._value);

  final ReauthorizeState _value;

  @override
  ReauthorizeState flowInfo(AuthFlowInfo? flowInfo) => call(flowInfo: flowInfo);

  @override
  ReauthorizeState generalError(LoginGeneralError? generalError) =>
      call(generalError: generalError);

  @override
  ReauthorizeState inProgress(bool inProgress) => call(inProgress: inProgress);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReauthorizeState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReauthorizeState(...).copyWith(id: 12, name: "My name")
  /// ```
  ReauthorizeState call({
    Object? flowInfo = const $CopyWithPlaceholder(),
    Object? generalError = const $CopyWithPlaceholder(),
    Object? inProgress = const $CopyWithPlaceholder(),
  }) {
    return ReauthorizeState(
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
    );
  }
}

extension $ReauthorizeStateCopyWith on ReauthorizeState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReauthorizeState.copyWith(...)` or `instanceOfReauthorizeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReauthorizeStateCWProxy get copyWith => _$ReauthorizeStateCWProxyImpl(this);
}

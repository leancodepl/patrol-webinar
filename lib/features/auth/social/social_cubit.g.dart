// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SocialStateIdleCWProxy {
  SocialStateIdle inProgress(bool inProgress);

  SocialStateIdle flowInfo(AuthFlowInfo? flowInfo);

  SocialStateIdle generalError(SocialGeneralError? generalError);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SocialStateIdle(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SocialStateIdle(...).copyWith(id: 12, name: "My name")
  /// ```
  SocialStateIdle call({
    bool inProgress,
    AuthFlowInfo? flowInfo,
    SocialGeneralError? generalError,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSocialStateIdle.copyWith(...)` or call `instanceOfSocialStateIdle.copyWith.fieldName(value)` for a single field.
class _$SocialStateIdleCWProxyImpl implements _$SocialStateIdleCWProxy {
  const _$SocialStateIdleCWProxyImpl(this._value);

  final SocialStateIdle _value;

  @override
  SocialStateIdle inProgress(bool inProgress) => call(inProgress: inProgress);

  @override
  SocialStateIdle flowInfo(AuthFlowInfo? flowInfo) => call(flowInfo: flowInfo);

  @override
  SocialStateIdle generalError(SocialGeneralError? generalError) =>
      call(generalError: generalError);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SocialStateIdle(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SocialStateIdle(...).copyWith(id: 12, name: "My name")
  /// ```
  SocialStateIdle call({
    Object? inProgress = const $CopyWithPlaceholder(),
    Object? flowInfo = const $CopyWithPlaceholder(),
    Object? generalError = const $CopyWithPlaceholder(),
  }) {
    return SocialStateIdle(
      inProgress:
          inProgress == const $CopyWithPlaceholder() || inProgress == null
          ? _value.inProgress
          // ignore: cast_nullable_to_non_nullable
          : inProgress as bool,
      flowInfo: flowInfo == const $CopyWithPlaceholder()
          ? _value.flowInfo
          // ignore: cast_nullable_to_non_nullable
          : flowInfo as AuthFlowInfo?,
      generalError: generalError == const $CopyWithPlaceholder()
          ? _value.generalError
          // ignore: cast_nullable_to_non_nullable
          : generalError as SocialGeneralError?,
    );
  }
}

extension $SocialStateIdleCopyWith on SocialStateIdle {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSocialStateIdle.copyWith(...)` or `instanceOfSocialStateIdle.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SocialStateIdleCWProxy get copyWith => _$SocialStateIdleCWProxyImpl(this);
}

abstract class _$SocialStateTraitsStepCWProxy {
  SocialStateTraitsStep inProgress(bool inProgress);

  SocialStateTraitsStep flowInfo(AuthFlowInfo? flowInfo);

  SocialStateTraitsStep generalError(SocialGeneralError? generalError);

  SocialStateTraitsStep provider(OidcProvider provider);

  SocialStateTraitsStep idToken(String? idToken);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SocialStateTraitsStep(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SocialStateTraitsStep(...).copyWith(id: 12, name: "My name")
  /// ```
  SocialStateTraitsStep call({
    bool inProgress,
    AuthFlowInfo? flowInfo,
    SocialGeneralError? generalError,
    OidcProvider provider,
    String? idToken,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSocialStateTraitsStep.copyWith(...)` or call `instanceOfSocialStateTraitsStep.copyWith.fieldName(value)` for a single field.
class _$SocialStateTraitsStepCWProxyImpl
    implements _$SocialStateTraitsStepCWProxy {
  const _$SocialStateTraitsStepCWProxyImpl(this._value);

  final SocialStateTraitsStep _value;

  @override
  SocialStateTraitsStep inProgress(bool inProgress) =>
      call(inProgress: inProgress);

  @override
  SocialStateTraitsStep flowInfo(AuthFlowInfo? flowInfo) =>
      call(flowInfo: flowInfo);

  @override
  SocialStateTraitsStep generalError(SocialGeneralError? generalError) =>
      call(generalError: generalError);

  @override
  SocialStateTraitsStep provider(OidcProvider provider) =>
      call(provider: provider);

  @override
  SocialStateTraitsStep idToken(String? idToken) => call(idToken: idToken);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SocialStateTraitsStep(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SocialStateTraitsStep(...).copyWith(id: 12, name: "My name")
  /// ```
  SocialStateTraitsStep call({
    Object? inProgress = const $CopyWithPlaceholder(),
    Object? flowInfo = const $CopyWithPlaceholder(),
    Object? generalError = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
    Object? idToken = const $CopyWithPlaceholder(),
  }) {
    return SocialStateTraitsStep(
      inProgress:
          inProgress == const $CopyWithPlaceholder() || inProgress == null
          ? _value.inProgress
          // ignore: cast_nullable_to_non_nullable
          : inProgress as bool,
      flowInfo: flowInfo == const $CopyWithPlaceholder()
          ? _value.flowInfo
          // ignore: cast_nullable_to_non_nullable
          : flowInfo as AuthFlowInfo?,
      generalError: generalError == const $CopyWithPlaceholder()
          ? _value.generalError
          // ignore: cast_nullable_to_non_nullable
          : generalError as SocialGeneralError?,
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as OidcProvider,
      idToken: idToken == const $CopyWithPlaceholder()
          ? _value.idToken
          // ignore: cast_nullable_to_non_nullable
          : idToken as String?,
    );
  }
}

extension $SocialStateTraitsStepCopyWith on SocialStateTraitsStep {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSocialStateTraitsStep.copyWith(...)` or `instanceOfSocialStateTraitsStep.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SocialStateTraitsStepCWProxy get copyWith =>
      _$SocialStateTraitsStepCWProxyImpl(this);
}

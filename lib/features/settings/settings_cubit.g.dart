// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppSettingsStateCWProxy {
  AppSettingsState useGrid(bool useGrid);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AppSettingsState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AppSettingsState(...).copyWith(id: 12, name: "My name")
  /// ```
  AppSettingsState call({bool useGrid});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAppSettingsState.copyWith(...)` or call `instanceOfAppSettingsState.copyWith.fieldName(value)` for a single field.
class _$AppSettingsStateCWProxyImpl implements _$AppSettingsStateCWProxy {
  const _$AppSettingsStateCWProxyImpl(this._value);

  final AppSettingsState _value;

  @override
  AppSettingsState useGrid(bool useGrid) => call(useGrid: useGrid);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AppSettingsState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AppSettingsState(...).copyWith(id: 12, name: "My name")
  /// ```
  AppSettingsState call({Object? useGrid = const $CopyWithPlaceholder()}) {
    return AppSettingsState(
      useGrid: useGrid == const $CopyWithPlaceholder() || useGrid == null
          ? _value.useGrid
          // ignore: cast_nullable_to_non_nullable
          : useGrid as bool,
    );
  }
}

extension $AppSettingsStateCopyWith on AppSettingsState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAppSettingsState.copyWith(...)` or `instanceOfAppSettingsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AppSettingsStateCWProxy get copyWith => _$AppSettingsStateCWProxyImpl(this);
}

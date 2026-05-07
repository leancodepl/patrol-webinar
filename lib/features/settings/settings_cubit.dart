import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_cubit.g.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({required this.sharedPreferences})
    : super(
        AppSettingsState(useGrid: sharedPreferences.getBool(_gridKey) ?? false),
      );

  final SharedPreferences sharedPreferences;
  static const _gridKey = 'useGrid';

  Future<void> setUseProvidersGrid(bool value) async {
    await sharedPreferences.setBool(_gridKey, value);
    emit(state.copyWith(useGrid: value));
  }
}

@CopyWith()
final class AppSettingsState with EquatableMixin {
  const AppSettingsState({required this.useGrid});

  final bool useGrid;

  @override
  List<Object?> get props => [useGrid];
}

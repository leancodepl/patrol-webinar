// We need simple colors here
// ignore_for_file: app_lint/use_design_system_item_AppColors
import 'package:app_design_system/app_design_system.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

class ScaffoldWidgetTestsWrapper extends StatelessWidget {
  const ScaffoldWidgetTestsWrapper({
    super.key,
    required this.scaffold,
    this.useMediaQueryPadding = false,
    this.useMediaQueryViewInsets = false,
  });

  final AppScaffold scaffold;
  final bool useMediaQueryPadding;
  final bool useMediaQueryViewInsets;

  static const mediaQueryPaddingValue = 30.0;
  static const mediaQueryPadding = EdgeInsets.all(mediaQueryPaddingValue);
  static const mediaQueryViewInsetsValue = 200.0;
  static const mediaQueryViewInsets = EdgeInsets.only(
    bottom: mediaQueryViewInsetsValue,
  );

  static const height = 600.0;
  static const width = 800.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Localizations(
        locale: const Locale('en'),
        delegates: AppDesignSystemLocalizations.localizationsDelegates,
        child: AppColorTheme(
          colors: AppColorThemes.light,
          child: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                padding: useMediaQueryPadding ? mediaQueryPadding : null,
                viewInsets: useMediaQueryViewInsets
                    ? mediaQueryViewInsets
                    : null,
              ),
              child: scaffold,
            ),
          ),
        ),
      ),
    );
  }
}

class FabPlaceholder extends StatelessWidget {
  const FabPlaceholder({super.key});

  static const height = 50.0;
  static const width = 50.0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: height, width: width, child: Placeholder());
  }
}

Map<Key, Widget> getKeyedPlaceholderTiles(int count) {
  return Map.fromEntries(
    buildPlaceholderTiles(count).mapIndexed((index, tile) {
      final key = Key('Tile#$index');

      return MapEntry(key, KeyedSubtree(key: key, child: tile));
    }),
  );
}

const placeholderTileHeight = 50.0;

List<Widget> buildPlaceholderTiles([int count = 15]) {
  return List.generate(
    count,
    (index) => Container(
      color: [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.purple,
        Colors.red,
      ][index % 5],
      height: placeholderTileHeight,
      alignment: AlignmentDirectional.center,
      padding: AppSpacings.s8.all,
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: [
          for (var i = 0; i < index + 1; i++)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
        ],
      ),
    ),
  );
}

class AppTopBarPlaceholder extends AppTopBar {
  const AppTopBarPlaceholder({super.key});

  @override
  AppTopBarPlaceholderState createState() => AppTopBarPlaceholderState();
}

class AppTopBarPlaceholderState extends State<AppTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(width: 2),
      ),
    );
  }
}

class FooterPlaceholder extends StatelessWidget {
  const FooterPlaceholder({super.key});

  static const height = 120.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.green.withValues(alpha: 0.75),
          border: Border.all(width: 2, color: Colors.green.shade700),
        ),
      ),
    );
  }
}

class DeviceFrameForScaffold extends StatelessWidget {
  const DeviceFrameForScaffold({super.key, required this.child});

  final Widget child;

  static const height = 650.0;
  static const width = 320.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: context.colors.foregroundDefaultPrimary,
        ),
      ),
      child: child,
    );
  }
}

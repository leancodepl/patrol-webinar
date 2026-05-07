import 'package:leancode_lint/plugin.dart';

final plugin = LeanCodeLintPlugin(
  name: 'app_lint',
  config: const LeanCodeLintConfig(
    applicationPrefix: 'App',
    designSystemItemReplacements: {
      'AppTextField': [
        DesignSystemForbiddenItem(name: 'TextField', packageName: 'flutter'),
      ],
      'AppColors or AppTextStyles': [
        DesignSystemForbiddenItem(name: 'Theme', packageName: 'flutter'),
      ],
      'AppColor': [
        DesignSystemForbiddenItem(name: 'Color', packageName: 'dart:ui'),
      ],
      'AppColors': [
        DesignSystemForbiddenItem(name: 'Colors', packageName: 'flutter'),
        DesignSystemForbiddenItem(name: 'ColorScheme', packageName: 'flutter'),
      ],
      'AppColorTween': [
        DesignSystemForbiddenItem(name: 'ColorTween', packageName: 'flutter'),
      ],
      'AppText': [
        DesignSystemForbiddenItem(name: 'Text', packageName: 'flutter'),
      ],
      'AppTextStyle': [
        DesignSystemForbiddenItem(name: 'TextStyle', packageName: 'flutter'),
      ],
      'AppTextSpan': [
        DesignSystemForbiddenItem(name: 'TextSpan', packageName: 'flutter'),
      ],
      'AppWidgetSpan': [
        DesignSystemForbiddenItem(name: 'WidgetSpan', packageName: 'flutter'),
      ],
      'AppDefaultTextStyle': [
        DesignSystemForbiddenItem(
          name: 'DefaultTextStyle',
          packageName: 'flutter',
        ),
      ],
      'AppScaffold': [
        DesignSystemForbiddenItem(name: 'Scaffold', packageName: 'flutter'),
      ],
      'AppIcon': [
        DesignSystemForbiddenItem(name: 'Icon', packageName: 'flutter'),
      ],
    },
  ),
);

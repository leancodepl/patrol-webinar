import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

part 'test_app_utils.dart';

final _mediaQueryKey = GlobalKey<_MediaQueryState>();

class _RootMediaQuery extends InheritedWidget {
  _RootMediaQuery({required super.child, required MediaQueryData data})
    : data = data.copyWith(textScaler: TextScaler.noScaling);

  final MediaQueryData data;

  static MediaQueryData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RootMediaQuery>()!.data;
  }

  @override
  bool updateShouldNotify(_RootMediaQuery oldWidget) {
    return oldWidget.data != data;
  }
}

class GoldenMediaQuery extends StatelessWidget {
  const GoldenMediaQuery({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(data: _RootMediaQuery.of(context), child: child);
  }
}

class _MediaQuery extends StatefulWidget {
  _MediaQuery({required this.child}) : super(key: _mediaQueryKey);

  final Widget child;

  @override
  State<_MediaQuery> createState() => _MediaQueryState();
}

class _MediaQueryState extends State<_MediaQuery> {
  var _boldText = false;
  var _textDirection = TextDirection.ltr;

  void update({bool? boldText, TextDirection? textDirection}) {
    setState(() {
      _boldText = boldText ?? _boldText;
      _textDirection = textDirection ?? _textDirection;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return _RootMediaQuery(
      data: data,
      child: MediaQuery(
        data: data.copyWith(boldText: _boldText),
        child: Directionality(
          textDirection: _textDirection,
          child: widget.child,
        ),
      ),
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key, required this.child});

  final Widget child;
  final locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return AppCore(
      colors: AppColorThemes.light,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppDesignSystemLocalizations.supportedLocales,
      home: _MediaQuery(
        child: AppScaffold(
          useBodyPadding: false,
          body: Align(alignment: Alignment.topCenter, child: child),
        ),
      ),
    );
  }
}

const _screenSize = Size(390, 844);

Future<void> pumpWidgetBuilder(
  WidgetTester tester,
  Widget widget, {
  bool fill = false,
  Surface surface = Surface.screen,
}) async {
  await (FontLoader(AppTextStyles.bodyDefault.fontFamily!)
        ..addFont(rootBundle.load('fonts/Inter-Medium.otf'))
        ..addFont(rootBundle.load('fonts/Inter-Bold.otf'))
        ..addFont(rootBundle.load('fonts/Inter-BoldItalic.otf'))
        ..addFont(rootBundle.load('fonts/Inter-MediumItalic.otf'))
        ..addFont(rootBundle.load('fonts/Inter-SemiBold.otf')))
      .load();

  const icon = AppStandardIcons.activity;
  String fontName(IconData icon) =>
      'packages/${icon.fontPackage!}/${icon.fontFamily!}';
  await (FontLoader(
    fontName(icon.s16),
  )..addFont(rootBundle.load('fonts/AppStandardIcons-16.ttf'))).load();
  await (FontLoader(
    fontName(icon.s24),
  )..addFont(rootBundle.load('fonts/AppStandardIcons-24.ttf'))).load();
  await (FontLoader(
    fontName(icon.s32),
  )..addFont(rootBundle.load('fonts/AppStandardIcons-32.ttf'))).load();

  return tester.pumpWidgetBuilder(
    widget,
    surfaceSize: surface.size,
    wrapper: (widget) => TestApp(
      child: fill ? widget : SizedBox(width: double.infinity, child: widget),
    ),
  );
}

class Surface {
  const Surface._(this.size);

  Surface.canvas({double width = 800, double height = 844})
    : this._(Size(width, height));

  static const screen = Surface._(_screenSize);

  final Size size;
}

Future<void> widgetsMatchGoldens(
  WidgetTester tester,
  String name, {
  Surface surface = Surface.screen,
  bool autoHeight = false,
}) async {
  await multiScreenGolden(
    tester,
    name,
    autoHeight: autoHeight,
    devices: [
      Device(name: 'light', size: surface.size),
      Device(name: 'large_text', size: surface.size, textScale: 1.35),
      Device(name: 'small_text', size: surface.size, textScale: 0.85),
    ],
  );

  _mediaQueryKey.currentState?.update(
    boldText: true,
    textDirection: TextDirection.ltr,
  );

  await multiScreenGolden(
    tester,
    name,
    autoHeight: autoHeight,
    devices: [Device(name: 'bold_text', size: surface.size)],
  );

  _mediaQueryKey.currentState?.update(
    boldText: false,
    textDirection: TextDirection.rtl,
  );

  await multiScreenGolden(
    tester,
    name,
    autoHeight: autoHeight,
    devices: [Device(name: 'rtl', size: surface.size)],
  );
}

Future<void> widgetsMatchGoldensSingle(
  WidgetTester tester,
  String name, {
  Surface surface = Surface.screen,
  bool autoHeight = false,
}) {
  return multiScreenGolden(
    tester,
    name,
    autoHeight: autoHeight,
    devices: [Device(name: 'light', size: surface.size)],
  );
}

Future<void> widgetsMatchGoldensRtl(
  WidgetTester tester,
  String name, {
  Surface surface = Surface.screen,
  bool autoHeight = false,
}) async {
  await multiScreenGolden(
    tester,
    name,
    autoHeight: autoHeight,
    devices: [Device(name: 'light', size: surface.size)],
  );
  _mediaQueryKey.currentState?.update(
    boldText: false,
    textDirection: TextDirection.rtl,
  );

  await multiScreenGolden(
    tester,
    name,
    autoHeight: autoHeight,
    devices: [Device(name: 'rtl', size: surface.size)],
  );
}

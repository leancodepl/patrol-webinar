part of 'test_app.dart';

typedef GoldenTableCellWrapper =
    Widget Function(BuildContext context, Widget child);

class GlobalKeyGenerator extends Iterable<GlobalKey> {
  final keys = <GlobalKey>[];

  GlobalKey next() {
    final key = GlobalKey();
    keys.add(key);
    return key;
  }

  @override
  Iterator<GlobalKey> get iterator => keys.iterator;
}

class ScrollControllerGenerator extends Iterable<ScrollController> {
  final controllers = <ScrollController>[];

  ScrollController next() {
    final controller = ScrollController();
    controllers.add(controller);
    return controller;
  }

  @override
  Iterator<ScrollController> get iterator => controllers.iterator;
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> tapDown(GlobalKey key) async {
    final finder = find.byKey(key);
    final offset = getRect(finder).center;
    await startGesture(offset);
  }

  Future<void> tapDownAll(Iterable<GlobalKey> keys) async {
    for (final key in keys) {
      await tapDown(key);
    }
  }

  Future<void> tapAll(Iterable<GlobalKey> keys) async {
    for (final key in keys) {
      await tap(find.byKey(key));
    }
  }

  Future<void> jumpToAll(
    Iterable<ScrollController> controllers,
    double value,
  ) async {
    for (final controller in controllers) {
      controller.jumpTo(value);
      await pumpAndSettle();
    }
  }
}

class GoldenRow extends StatelessWidget {
  const GoldenRow({
    super.key,
    this.children = const [],
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: children,
    );
  }
}

class GoldenColumn extends StatelessWidget {
  const GoldenColumn({super.key, this.children = const []});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(textDirection: TextDirection.ltr, children: children);
  }
}

class GoldenText extends StatelessWidget {
  const GoldenText(
    this.text, {
    super.key,
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final AppTextStyle style;
  final AppColor? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colors.foregroundDefaultPrimary;

    return MediaQuery(
      data: _RootMediaQuery.of(context),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AppText(
          text,
          style: style,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
        ),
      ),
    );
  }
}

class _GoldenTableConfig extends InheritedWidget {
  const _GoldenTableConfig({
    required this.alignment,
    required super.child,
    required this.cellFlex,
  });

  final GoldenTableCellAlignment alignment;
  final int cellFlex;

  static _GoldenTableConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_GoldenTableConfig>()!;
  }

  @override
  bool updateShouldNotify(_GoldenTableConfig oldWidget) {
    return oldWidget.alignment != alignment || oldWidget.cellFlex != cellFlex;
  }
}

class GoldenTable extends StatelessWidget {
  const GoldenTable({
    super.key,
    required this.header,
    this.cellAlignment = GoldenTableCellAlignment.center,
    this.cellWrapper,
    this.cellFlex = 100,
    this.rows = const [],
  });

  final GoldenTableCellAlignment cellAlignment;
  final GoldenTableHeader header;
  final List<GoldenTableRow> rows;
  final GoldenTableCellWrapper? cellWrapper;
  final int cellFlex;

  @override
  Widget build(BuildContext context) {
    return _GoldenTableConfig(
      cellFlex: cellFlex,
      alignment: cellAlignment,
      child: _GoldenTableCellWrapperProvider(
        wrapper: cellWrapper,
        child: GoldenColumn(
          children: [header, AppSpacings.s8.verticalSpace, ...rows],
        ),
      ),
    );
  }
}

class GoldenTableHeader extends StatelessWidget {
  const GoldenTableHeader({
    super.key,
    this.headerName,
    this.cellNames = const [],
  });

  final String? headerName;
  final List<String> cellNames;

  @override
  Widget build(BuildContext context) {
    final _GoldenTableConfig(:cellFlex) = _GoldenTableConfig.of(context);

    final children = [
      if (headerName case final headerName?)
        Expanded(
          flex: 100,
          child: Align(
            alignment: Alignment.topLeft,
            child: GoldenText(headerName, style: AppTextStyles.bodyStrong),
          ),
        ),
      ...cellNames.map(
        (name) => Expanded(
          flex: cellFlex,
          child: Align(
            alignment: Alignment.topCenter,
            child: GoldenText(name, style: AppTextStyles.bodyStrong),
          ),
        ),
      ),
    ];

    return ColoredBox(
      color: context.colors.backgroundDefaultSecondary,
      child: Padding(
        padding: AppSpacings.s8.vertical + AppSpacings.s16.horizontal,
        child: GoldenRow(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

enum GoldenTableCellAlignment { center, stretch }

class GoldenTableRow extends StatelessWidget {
  const GoldenTableRow({
    super.key,
    this.details,
    this.cells = const [],
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final String? details;
  final List<Widget> cells;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final _GoldenTableConfig(:alignment, :cellFlex) = _GoldenTableConfig.of(
      context,
    );

    final cellWrapper = _GoldenTableCellWrapperProvider.of(context);

    final children = [
      for (final cell in cells) cellWrapper?.call(context, cell) ?? cell,
    ];

    return Padding(
      padding: AppSpacings.s4.vertical + AppSpacings.s16.horizontal,
      child: GoldenRow(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (details case final details?)
            Expanded(
              flex: 100,
              child: GoldenText(details, style: AppTextStyles.bodyDefault),
            ),
          for (final child in children)
            Expanded(
              flex: cellFlex,
              child: Padding(
                padding: AppSpacings.s8.horizontal,
                child: switch (alignment) {
                  GoldenTableCellAlignment.center => Center(child: child),
                  _ => child,
                },
              ),
            ),
        ],
      ),
    );
  }
}

class GoldenScreen extends StatelessWidget {
  const GoldenScreen({super.key, required this.alignment, required this.child});

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        padding:
            (AppSpacings.s16.horizontal +
                    AppSpacings.s24.bottom +
                    AppSpacings.s12.top)
                .resolve(Directionality.of(context)),
      ),
      child: AppCore(
        locale: Locale(context.l10n.localeName),
        supportedLocales: AppDesignSystemLocalizations.supportedLocales,
        localizationsDelegates:
            AppDesignSystemLocalizations.localizationsDelegates,
        colors: context.colors,
        debugShowCheckedModeBanner: false,
        home: Material(
          color: context.colors.backgroundSuccessTertiary,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: AppSpacings.s16.value,
                child: AppText(
                  'Safe area padding',
                  style: AppTextStyles.bodyDefault,
                  color: context.colors.foregroundSuccessPrimary,
                ),
              ),
              SafeArea(
                child: ColoredBox(
                  color: context.colors.backgroundDefaultPrimary,
                  child: Align(alignment: alignment, child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldenTableCellWrapperProvider extends InheritedWidget {
  const _GoldenTableCellWrapperProvider({
    required this.wrapper,
    required super.child,
  });

  final GoldenTableCellWrapper? wrapper;

  static GoldenTableCellWrapper? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_GoldenTableCellWrapperProvider>()
      ?.wrapper;

  @override
  bool updateShouldNotify(_GoldenTableCellWrapperProvider oldWidget) =>
      oldWidget.wrapper != wrapper;
}

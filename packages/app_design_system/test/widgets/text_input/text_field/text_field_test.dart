import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../test_app.dart';

T? _valueOrNull<T>(T? element, {required bool visible}) => switch (visible) {
  true => element,
  false => null,
};

class _FocusedFocusNodeStub extends FocusNode {
  @override
  bool get hasFocus => true;
}

void main() {
  group('AppTextField', () {
    const defaultDecoration = AppTextFieldDecoration(
      size: AppTextFieldSize.large,
      label: 'Label',
      leadingIcon: AppStandardIcons.messageSmileSquare,
      leadingOption: AppTextFieldOption(label: 'Leading option', items: []),
      prefix: 'Prefix',
      placeholder: 'Placeholder',
      suffix: 'Suffix',
      trailingOption: AppTextFieldOption(label: 'Trailing option', items: []),
      trailingIcon: AppStandardIcons.chevronSelectorVertical,
      help: 'Help',
      error: 'Error text',
      hint: 'Hint text',
    );

    testGoldens('states', (tester) async {
      final surface = Surface.canvas(height: 2200, width: 1000);

      final keys = GlobalKeyGenerator();

      GoldenTableRow getTextFieldRow({
        bool error = false,
        bool focused = false,
        bool enabled = true,
        required AppTextFieldSize size,
      }) {
        final decoration = AppTextFieldDecoration(
          size: size,
          label: defaultDecoration.label,
          leadingIcon: defaultDecoration.leadingIcon,
          leadingOption: defaultDecoration.leadingOption,
          prefix: defaultDecoration.prefix,
          placeholder: defaultDecoration.placeholder,
          suffix: defaultDecoration.suffix,
          trailingOption: defaultDecoration.trailingOption,
          trailingIcon: defaultDecoration.trailingIcon,
          help: defaultDecoration.help,
          error: switch (error) {
            true => defaultDecoration.error,
            false => null,
          },
          hint: defaultDecoration.hint,
        );

        return GoldenTableRow(
          details:
              'Error: $error\n'
              'Enabled: $enabled\n'
              'Size: ${size.name}',
          cells: [
            AppTextField(
              focusNode: switch (focused) {
                true => _FocusedFocusNodeStub(),
                false => null,
              },
              enabled: enabled,
              decoration: decoration,
            ),
          ],
        );
      }

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 300,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Default'],
          ),
          rows: [
            for (final size in {
              AppTextFieldSize.medium,
              AppTextFieldSize.large,
            })
              for (final error in {false, true})
                for (final enabled in {true, false})
                  for (final focused in {false, true})
                    getTextFieldRow(
                      size: size,
                      error: error,
                      enabled: enabled,
                      focused: focused,
                    ),
          ],
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'text_field_states', surface: surface);
    });

    testGoldens('combinations', (tester) async {
      final surface = Surface.canvas(height: 5000, width: 1000);

      final keys = GlobalKeyGenerator();

      GoldenTableRow getTextFieldRow({
        required bool icons,
        required bool options,
        required bool prefixAndSuffix,
        required bool action,
        required bool hint,
      }) {
        final decoration = AppTextFieldDecoration(
          label: defaultDecoration.label,
          leadingIcon: _valueOrNull(
            defaultDecoration.leadingIcon,
            visible: icons,
          ),
          leadingOption: _valueOrNull(
            defaultDecoration.leadingOption,
            visible: options,
          ),
          prefix: _valueOrNull(
            defaultDecoration.prefix,
            visible: prefixAndSuffix,
          ),
          placeholder: defaultDecoration.placeholder,
          suffix: _valueOrNull(
            defaultDecoration.suffix,
            visible: prefixAndSuffix,
          ),
          trailingOption: _valueOrNull(
            defaultDecoration.trailingOption,
            visible: options,
          ),
          trailingIcon: _valueOrNull(
            defaultDecoration.trailingIcon,
            visible: icons,
          ),
          help: defaultDecoration.help,
          hint: _valueOrNull(defaultDecoration.hint, visible: hint),
        );

        return GoldenTableRow(
          details:
              'Icons: $icons\n'
              'Options: $options\n'
              'Preffix and suffix: $prefixAndSuffix\n'
              'Action: $action\n'
              'Hint: $hint\n',
          cells: [AppTextField(decoration: decoration)],
        );
      }

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 300,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Default'],
          ),
          rows: [
            for (final icons in {true, false})
              for (final options in {true, false})
                for (final prefixAndSuffix in {true, false})
                  for (final action in {true, false})
                    for (final hint in {true, false})
                      getTextFieldRow(
                        icons: icons,
                        options: options,
                        prefixAndSuffix: prefixAndSuffix,
                        action: action,
                        hint: hint,
                      ),
          ],
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'text_field_combinations',
        surface: surface,
      );
    });

    testGoldens('label & clear button', (tester) async {
      final surface = Surface.canvas(height: 2000, width: 600);

      GoldenTableRow getTextFieldRow({
        bool enabled = true,
        bool focused = false,
        bool textValue = false,
        required AppTextFieldSize size,
      }) {
        final decoration = AppTextFieldDecoration(
          size: size,
          label: defaultDecoration.label,
        );

        return GoldenTableRow(
          details:
              'Enabled: $enabled\n'
              'Focused: $focused\n'
              'Text value: $textValue\n'
              'Size: ${size.name}',
          cells: [
            AppTextField(
              controller: switch (focused) {
                true => TextEditingController(text: 'Value'),
                false => null,
              },
              focusNode: switch (focused) {
                true => _FocusedFocusNodeStub(),
                false => null,
              },
              enabled: enabled,
              decoration: decoration,
            ),
          ],
        );
      }

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 150,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Default'],
          ),
          rows: [
            for (final size in {
              AppTextFieldSize.medium,
              AppTextFieldSize.large,
            })
              for (final textValue in {false, true})
                for (final enabled in {true, false})
                  for (final focused in {false, true})
                    getTextFieldRow(
                      size: size,
                      enabled: enabled,
                      focused: focused,
                      textValue: textValue,
                    ),
          ],
        ),
        surface: surface,
      );

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'text_field_text_and_clear_button',
        surface: surface,
      );
    });

    testWidgets('no FlutterError if no Material above', (tester) async {
      await tester.pumpWidget(
        const AppCore(
          colors: AppColorThemes.light,
          home: AppTextField(decoration: defaultDecoration),
        ),
      );
    });

    testWidgets('intrinsics', (tester) async {
      debugCheckIntrinsicSizes = true;

      await tester.pumpWidgetBuilder(
        TestApp(
          child: SizedBox.fromSize(
            size: Surface.screen.size,
            child: const AppTextField(decoration: defaultDecoration),
          ),
        ),
        surfaceSize: Surface.screen.size,
      );

      await tester.pumpAndSettle();
    }, skip: true);
  });
}

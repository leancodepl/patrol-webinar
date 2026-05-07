import 'package:app_design_system/app_design_system.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  testGoldens('AppListItem', (tester) async {
    final surface = Surface.canvas(width: 500, height: 1800);

    const overline = 'Overline';
    const veryLongOverline =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    const title = 'Title';
    const veryLongTitle =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    const subtitle = 'Subtitle';
    const veryLongSubtitle =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    final keys = GlobalKeyGenerator();

    final builder = AppGoldenBuilder.column(name: 'AppListItem');
    final scenarios = [
      (
        name: 'Default',
        longOverline: false,
        longTitle: false,
        longSubtitle: false,
        showValue: false,
        showToggle: false,
        showButton: false,
        showLeadingIcon: false,
        showTrailingIcon: false,
        pressed: false,
      ),
      (
        name: 'With actions',
        longOverline: false,
        longTitle: false,
        longSubtitle: false,
        showValue: false,
        showToggle: true,
        showButton: true,
        showLeadingIcon: false,
        showTrailingIcon: false,
        pressed: false,
      ),
      (
        name: 'With actions, with icons',
        longOverline: false,
        longTitle: false,
        longSubtitle: false,
        showValue: false,
        showToggle: true,
        showButton: true,
        showLeadingIcon: true,
        showTrailingIcon: true,
        pressed: false,
      ),
      (
        name: 'with actions, with icons, with long text',
        longOverline: true,
        longTitle: true,
        longSubtitle: true,
        showValue: false,
        showToggle: true,
        showButton: true,
        showLeadingIcon: true,
        showTrailingIcon: true,
        pressed: false,
      ),
      (
        name: 'with actions, with icons, with long text, with value',
        longOverline: true,
        longTitle: true,
        longSubtitle: true,
        showValue: true,
        showToggle: true,
        showButton: true,
        showLeadingIcon: true,
        showTrailingIcon: true,
        pressed: false,
      ),
      (
        name: 'with actions, with icons, with long text, with value, pressed',
        longOverline: true,
        longTitle: true,
        longSubtitle: true,
        showValue: true,
        showToggle: true,
        showButton: true,
        showLeadingIcon: true,
        showTrailingIcon: true,
        pressed: true,
      ),
    ];

    for (final scenario in scenarios) {
      builder.addScenario(
        scenario.name,
        AppListItem(
          key: scenario.pressed ? keys.next() : null,
          onTap: scenario.pressed ? () {} : null,
          overline: scenario.longOverline ? veryLongOverline : overline,
          title: scenario.longTitle ? veryLongTitle : title,
          subtitle: scenario.longSubtitle ? veryLongSubtitle : subtitle,
          value: scenario.showValue ? 'Value' : null,
          toggle: scenario.showToggle
              ? AppListItemToggle(value: true, onToggleChanged: (_) {})
              : null,
          button: scenario.showButton
              ? AppListItemButton(
                  icon: AppStandardIcons.flash,
                  semanticsLabel: '',
                  onTap: () {},
                )
              : null,
          leadingIcon: scenario.showLeadingIcon
              ? AppListItemIcon.icon(
                  icon: AppStandardIcons.cloud01,
                  semanticsLabel: null,
                )
              : null,
          trailingIcon: scenario.showTrailingIcon
              ? AppListItemIcon.icon(
                  icon: AppStandardIcons.chevronRight,
                  semanticsLabel: null,
                )
              : null,
        ),
      );
    }

    await pumpWidgetBuilder(tester, builder.build(), surface: surface);

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'list_item', surface: surface);
  });
}

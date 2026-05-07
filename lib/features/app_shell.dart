import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/config/app_global_keys.dart';
import 'package:fts/keys.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class AppShell extends HookWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  List<AppNavigationBarItem> _navBarItems(BuildContext context) {
    final s = l10n(context);
    return [
      AppNavigationBarItem(
        key: keys.appShell.homeTab,
        title: s.navBar_home,
        icon: AppStandardIcons.fts,
        selectedColor: context.colors.backgroundInversePrimary,
      ),
      AppNavigationBarItem(
        key: keys.appShell.agendaTab,
        title: s.navBar_agenda,
        icon: AppStandardIcons.list,
      ),
      AppNavigationBarItem(
        key: keys.appShell.mapTab,
        title: s.navBar_map,
        icon: AppStandardIcons.map01,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navBarItems = _navBarItems(context);

    final appNavigationBarController = useMemoized(
      () => AppNavigationBarController(
        initialPage: navigationShell.currentIndex,
        totalPages: navBarItems.length,
      ),
    );

    useEffect(() {
      if (appNavigationBarController.current != navigationShell.currentIndex) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          appNavigationBarController.changePage(navigationShell.currentIndex);
        });
      }
      return null;
    }, [navigationShell.currentIndex]);

    useEffect(() {
      appNavigationBarController.addListener(() {
        final router = GoRouterState.of(context);
        const homeIndex = 0;
        navigationShell.goBranch(
          appNavigationBarController.current,
          initialLocation:
              appNavigationBarController.current == homeIndex &&
              router.matchedLocation.startsWith('/home'),
        );
      });

      return appNavigationBarController.dispose;
    }, [appNavigationBarController]);

    return AppScaffold.navigationBar(
      navigationController: appNavigationBarController,
      navigationItems: navBarItems,
      navigationBarKey: context.read<AppGlobalKeys>().navigationBarKey,
      body: children[navigationShell.currentIndex],
    );
  }
}

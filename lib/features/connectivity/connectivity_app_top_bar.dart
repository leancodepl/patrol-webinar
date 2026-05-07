import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/features/connectivity/connectivity_banner.dart';

class ConnectivityAppTopBar extends AppTopBar {
  const ConnectivityAppTopBar({
    super.key,
    super.leading,
    super.centerTitle = true,
    super.title,
    super.subtitle,
    super.actions,
    super.menuActions,
    super.automaticallyImplyLeading = true,
    super.menuKey,
  }) : assert(
         title != null || subtitle == null,
         'Title cannot be null when subtitle is provided',
       );

  static const restoredConnectionVisibilityDuration = Duration(seconds: 2);

  @override
  State<ConnectivityAppTopBar> createState() => _ConnectivityTopBarState();
}

class _ConnectivityTopBarState extends State<ConnectivityAppTopBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTopBar(
          leading: widget.leading,
          centerTitle: widget.centerTitle,
          title: widget.title,
          subtitle: widget.subtitle,
          actions: widget.actions,
          menuActions: widget.menuActions,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          menuKey: widget.menuKey,
        ),
        const ConnectivityBanner(),
      ],
    );
  }
}

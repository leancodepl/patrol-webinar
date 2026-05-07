import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/session_details/session_details_header.dart';
import 'package:fts/features/session_details/widgets/static_map.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.session});

  final EventSession session;

  @override
  Widget build(BuildContext context) {
    return AppScaffold.widgets(
      topBar: const AppTopBar(divider: false),
      children: [
        SessionDetailsHeader(session: session),
        if (session.site case final site?) ...[
          AppSpacings.s24.verticalSpace,
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacings.s12.value),
              child: StaticMap(site: site),
            ),
          ),
        ],
      ],
    );
  }
}

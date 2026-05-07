import 'package:fts/features/agenda/session_tile.dart';

import 'module.dart';

final class Agenda extends Module {
  const Agenda(super.$);

  Future<void> tapFirstSession() async {
    await $(SessionTile).tap();
  }
}

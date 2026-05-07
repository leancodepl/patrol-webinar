import 'package:fts/data/contracts/contracts.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

class Track with EquatableMixin {
  const Track({required this.id, required this.name});

  factory Track.fromDto(SessionTrackDTO dto) =>
      Track(id: dto.id, name: dto.name);

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

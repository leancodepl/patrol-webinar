import 'package:equatable/equatable.dart';
import 'package:fts/features/agenda/models/speaker.dart';

class RoundTable with EquatableMixin {
  const RoundTable({
    required this.index,
    required this.title,
    required this.description,
    required this.moderator,
  });

  final int index;
  final String title;
  final String? description;
  final Speaker moderator;

  @override
  List<Object?> get props => [index, title, description, moderator];
}

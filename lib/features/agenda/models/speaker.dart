import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/resources/strings.dart';

class Speaker with EquatableMixin {
  Speaker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.flags,
    required this.companyName,
    required this.jobTitle,
    required this.photoUrl,
    required this.linkedInUrl,
    required this.bio,
    required this.companyPhotoUrl,
  });

  Speaker.fromDto(SpeakerDTO dto, {required Set<SpeakerFlag> flags})
    : this(
        id: dto.id,
        firstName: dto.firstName,
        lastName: dto.lastName,
        flags: flags,
        companyName: dto.companyName,
        jobTitle: dto.jobTitle,
        photoUrl: dto.photoUrl,
        linkedInUrl: dto.linkedInUrl,
        bio: dto.bio,
        companyPhotoUrl: dto.companyPhotoUrl,
      );

  final String id;
  final String firstName;
  final String lastName;
  final Set<SpeakerFlag> flags;
  final String? companyName;
  final String? jobTitle;
  final Uri? photoUrl;
  final Uri? linkedInUrl;
  final String? bio;
  final Uri? companyPhotoUrl;

  String get fullName => '$firstName $lastName';

  bool get isSpeaker => flags.contains(SpeakerFlag.speaker);
  bool get isModerator => flags.contains(SpeakerFlag.moderator);

  @override
  List<Object?> get props => [id];
}

enum SpeakerFlag {
  speaker,
  moderator;

  String getLabel(BuildContext context) {
    final s = l10n(context);

    return switch (this) {
      speaker => s.speakerDetails_speakerBadge,
      moderator => s.speakerDetails_moderatorBadge,
    };
  }
}

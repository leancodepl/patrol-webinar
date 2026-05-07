// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
import 'package:leancode_contracts/leancode_contracts.dart';
part 'contracts.g.dart';

@ContractsSerializable()
class Auth with EquatableMixin {
  Auth();

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

@ContractsSerializable()
class KnownClaims with EquatableMixin {
  KnownClaims();

  factory KnownClaims.fromJson(Map<String, dynamic> json) =>
      _$KnownClaimsFromJson(json);

  static const String userId = 'sub';

  static const String role = 'role';

  static const String notificationCenterToken = 'notification-center-token';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$KnownClaimsToJson(this);
}

@ContractsSerializable()
class Roles with EquatableMixin {
  Roles();

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  static const String user = 'user';

  static const String admin = 'admin';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$RolesToJson(this);
}

@ContractsSerializable()
class KratosIdentityDTO with EquatableMixin {
  KratosIdentityDTO({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.schemaId,
    required this.email,
  });

  factory KratosIdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$KratosIdentityDTOFromJson(json);

  final String id;

  final DateTimeOffset createdAt;

  final DateTimeOffset updatedAt;

  final String schemaId;

  final String email;

  List<Object?> get props => [id, createdAt, updatedAt, schemaId, email];

  Map<String, dynamic> toJson() => _$KratosIdentityDTOToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class SearchIdentities
    with EquatableMixin
    implements PaginatedQuery<KratosIdentityDTO> {
  SearchIdentities({
    required this.pageNumber,
    required this.pageSize,
    required this.schemaId,
    required this.emailPattern,
    required this.givenNamePattern,
    required this.familyNamePattern,
  });

  factory SearchIdentities.fromJson(Map<String, dynamic> json) =>
      _$SearchIdentitiesFromJson(json);

  /// Zero-based.
  final int pageNumber;

  final int pageSize;

  final String? schemaId;

  final String? emailPattern;

  final String? givenNamePattern;

  final String? familyNamePattern;

  List<Object?> get props => [
    pageNumber,
    pageSize,
    schemaId,
    emailPattern,
    givenNamePattern,
    familyNamePattern,
  ];

  Map<String, dynamic> toJson() => _$SearchIdentitiesToJson(this);

  PaginatedResult<KratosIdentityDTO> resultFactory(dynamic decodedJson) =>
      _$PaginatedResultFromJson(
        decodedJson as Map<String, dynamic>,
        (e) => _$KratosIdentityDTOFromJson(e as Map<String, dynamic>),
      );

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Identities.SearchIdentities';
}

@ContractsSerializable()
class CustomMessagePayload with EquatableMixin {
  CustomMessagePayload({
    required this.title,
    required this.content,
    this.deepLink,
  });

  factory CustomMessagePayload.fromJson(Map<String, dynamic> json) =>
      _$CustomMessagePayloadFromJson(json);

  final String title;

  final String content;

  final String? deepLink;

  List<Object?> get props => [title, content, deepLink];

  Map<String, dynamic> toJson() => _$CustomMessagePayloadToJson(this);
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class NotificationCenterToken with EquatableMixin implements Operation<String> {
  NotificationCenterToken();

  factory NotificationCenterToken.fromJson(Map<String, dynamic> json) =>
      _$NotificationCenterTokenFromJson(json);

  static const String headerName = 'X-Notification-Center-Token';

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$NotificationCenterTokenToJson(this);

  String resultFactory(dynamic decodedJson) => decodedJson as String;

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Notifications.NotificationCenterToken';
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class SendCustomMessage with EquatableMixin implements Command {
  SendCustomMessage({
    required this.title,
    required this.content,
    required this.deepLink,
    required this.notificationToken,
  });

  factory SendCustomMessage.fromJson(Map<String, dynamic> json) =>
      _$SendCustomMessageFromJson(json);

  final String title;

  final String content;

  final String? deepLink;

  final String? notificationToken;

  List<Object?> get props => [title, content, deepLink, notificationToken];

  Map<String, dynamic> toJson() => _$SendCustomMessageToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Notifications.SendCustomMessage';
}

class SendCustomMessageErrorCodes {
  static const titleEmpty = 1;

  static const contentEmpty = 2;
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class SendSessionStartingMessage with EquatableMixin implements Command {
  SendSessionStartingMessage({
    required this.sessionId,
    required this.title,
    required this.content,
    required this.notificationToken,
  });

  factory SendSessionStartingMessage.fromJson(Map<String, dynamic> json) =>
      _$SendSessionStartingMessageFromJson(json);

  final String sessionId;

  final String title;

  final String content;

  final String? notificationToken;

  List<Object?> get props => [sessionId, title, content, notificationToken];

  Map<String, dynamic> toJson() => _$SendSessionStartingMessageToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Notifications.SendSessionStartingMessage';
}

class SendSessionStartingMessageErrorCodes {
  static const sessionDoesNotExist = 1;

  static const titleEmpty = 2;

  static const contentEmpty = 3;
}

@ContractsSerializable()
class SessionStartingMessagePayload with EquatableMixin {
  SessionStartingMessagePayload({
    required this.sessionId,
    required this.title,
    required this.content,
  });

  factory SessionStartingMessagePayload.fromJson(Map<String, dynamic> json) =>
      _$SessionStartingMessagePayloadFromJson(json);

  final String sessionId;

  final String title;

  final String content;

  List<Object?> get props => [sessionId, title, content];

  Map<String, dynamic> toJson() => _$SessionStartingMessagePayloadToJson(this);
}

abstract class PaginatedQuery<TResult>
    with EquatableMixin
    implements Query<PaginatedResult<TResult>> {
  PaginatedQuery({required this.pageNumber, required this.pageSize});

  static const int minPageSize = 1;

  static const int maxPageSize = 100;

  /// Zero-based.
  final int pageNumber;

  final int pageSize;

  List<Object?> get props => [pageNumber, pageSize];
}

@ContractsSerializable(genericArgumentFactories: true)
class PaginatedResult<TResult> with EquatableMixin {
  PaginatedResult({required this.items, required this.totalCount});

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    TResult Function(Object?) fromJsonTResult,
  ) => _$PaginatedResultFromJson(json, fromJsonTResult);

  final List<TResult> items;

  final int totalCount;

  List<Object?> get props => [items, totalCount];
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class Agenda with EquatableMixin implements Query<List<SessionDTO>> {
  Agenda();

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$AgendaToJson(this);

  List<SessionDTO> resultFactory(dynamic decodedJson) =>
      (decodedJson as Iterable<dynamic>)
          .map((dynamic e) => _$SessionDTOFromJson(e as Map<String, dynamic>))
          .toList();

  String getFullName() => 'FlutterTechSummit.Core.Contracts.Sessions.Agenda';
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class EditAgenda with EquatableMixin implements Command {
  EditAgenda({required this.sessions});

  factory EditAgenda.fromJson(Map<String, dynamic> json) =>
      _$EditAgendaFromJson(json);

  final List<EditAgendaSessionDTO> sessions;

  List<Object?> get props => [sessions];

  Map<String, dynamic> toJson() => _$EditAgendaToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Sessions.EditAgenda';
}

class EditAgendaErrorCodes {
  static const sessionsListEmpty = 1;

  static const titleEmpty = 2;

  static const invalidSpeakerIds = 3;

  static const invalidSiteId = 4;

  static const invalidModeratorId = 5;

  static const invalidSessionDates = 6;

  static const roundtableSlotsMissingForRoundtableType = 7;

  static const roundtableSlotsProvidedForNonRoundtableType = 8;

  static const roundtableTopicEmpty = 9;

  static const invalidSessionType = 10;

  static const sessionDatesOverlapping = 11;
}

@ContractsSerializable()
class EditAgendaRoundtableSlotDTO with EquatableMixin {
  EditAgendaRoundtableSlotDTO({
    required this.topic,
    this.description,
    required this.moderatorId,
  });

  factory EditAgendaRoundtableSlotDTO.fromJson(Map<String, dynamic> json) =>
      _$EditAgendaRoundtableSlotDTOFromJson(json);

  final String topic;

  final String? description;

  final String moderatorId;

  List<Object?> get props => [topic, description, moderatorId];

  Map<String, dynamic> toJson() => _$EditAgendaRoundtableSlotDTOToJson(this);
}

@ContractsSerializable()
class EditAgendaSessionDTO with EquatableMixin {
  EditAgendaSessionDTO({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.speakerIds,
    this.siteId,
    this.roundtableSlots,
  });

  factory EditAgendaSessionDTO.fromJson(Map<String, dynamic> json) =>
      _$EditAgendaSessionDTOFromJson(json);

  final String id;

  final String title;

  final String? description;

  final DateTimeOffset startDate;

  final DateTimeOffset endDate;

  final SessionTypeDTO type;

  final List<String> speakerIds;

  final String? siteId;

  final List<EditAgendaRoundtableSlotDTO>? roundtableSlots;

  List<Object?> get props => [
    id,
    title,
    description,
    startDate,
    endDate,
    type,
    speakerIds,
    siteId,
    roundtableSlots,
  ];

  Map<String, dynamic> toJson() => _$EditAgendaSessionDTOToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('user')
@ContractsSerializable()
class RateSession with EquatableMixin implements Command {
  RateSession({
    required this.sessionId,
    required this.rating,
    required this.comment,
  });

  factory RateSession.fromJson(Map<String, dynamic> json) =>
      _$RateSessionFromJson(json);

  final String sessionId;

  final int rating;

  final String? comment;

  List<Object?> get props => [sessionId, rating, comment];

  Map<String, dynamic> toJson() => _$RateSessionToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Sessions.RateSession';
}

class RateSessionErrorCodes {
  static const sessionDoesNotExist = 1;

  static const onlyTalksCanBeRated = 2;

  static const ratingOutOfRange = 3;

  static const alreadyRated = 4;

  static const commentTooLong = 5;
}

@ContractsSerializable()
class RatingDTO with EquatableMixin {
  RatingDTO({required this.rating, this.comment});

  factory RatingDTO.fromJson(Map<String, dynamic> json) =>
      _$RatingDTOFromJson(json);

  final int rating;

  final String? comment;

  List<Object?> get props => [rating, comment];

  Map<String, dynamic> toJson() => _$RatingDTOToJson(this);
}

@ContractsSerializable()
class RoundtableSlotDTO with EquatableMixin {
  RoundtableSlotDTO({
    required this.topic,
    this.description,
    required this.moderator,
  });

  factory RoundtableSlotDTO.fromJson(Map<String, dynamic> json) =>
      _$RoundtableSlotDTOFromJson(json);

  final String topic;

  final String? description;

  final SpeakerDTO moderator;

  List<Object?> get props => [topic, description, moderator];

  Map<String, dynamic> toJson() => _$RoundtableSlotDTOToJson(this);
}

@ContractsSerializable()
class SessionDTO with EquatableMixin {
  SessionDTO({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.day,
    required this.type,
    required this.speakers,
    this.roundtableSlots,
    this.site,
    this.userRating,
    required this.tracks,
  });

  factory SessionDTO.fromJson(Map<String, dynamic> json) =>
      _$SessionDTOFromJson(json);

  final String id;

  final String title;

  final String? description;

  final DateTimeOffset startDate;

  final DateTimeOffset endDate;

  final DateOnly day;

  final SessionTypeDTO type;

  final List<SpeakerDTO> speakers;

  final List<RoundtableSlotDTO>? roundtableSlots;

  final SiteDTO? site;

  final RatingDTO? userRating;

  final List<SessionTrackDTO> tracks;

  List<Object?> get props => [
    id,
    title,
    description,
    startDate,
    endDate,
    day,
    type,
    speakers,
    roundtableSlots,
    site,
    userRating,
    tracks,
  ];

  Map<String, dynamic> toJson() => _$SessionDTOToJson(this);
}

@ContractsSerializable()
class SessionTrackDTO with EquatableMixin {
  SessionTrackDTO({required this.id, required this.name});

  factory SessionTrackDTO.fromJson(Map<String, dynamic> json) =>
      _$SessionTrackDTOFromJson(json);

  final String id;

  final String name;

  List<Object?> get props => [id, name];

  Map<String, dynamic> toJson() => _$SessionTrackDTOToJson(this);
}

enum SessionTypeDTO {
  @JsonValue(0)
  talk,
  @JsonValue(1)
  roundtable,
  @JsonValue(2)
  other,
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class AllSites with EquatableMixin implements Query<List<SiteDTO>> {
  AllSites();

  factory AllSites.fromJson(Map<String, dynamic> json) =>
      _$AllSitesFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$AllSitesToJson(this);

  List<SiteDTO> resultFactory(dynamic decodedJson) =>
      (decodedJson as Iterable<dynamic>)
          .map((dynamic e) => _$SiteDTOFromJson(e as Map<String, dynamic>))
          .toList();

  String getFullName() => 'FlutterTechSummit.Core.Contracts.Sites.AllSites';
}

enum SiteCategoryDTO {
  @JsonValue(0)
  event,
  @JsonValue(1)
  afterParty,
  @JsonValue(2)
  leanCodeOffice,
  @JsonValue(3)
  cultural,
  @JsonValue(4)
  museum,
  @JsonValue(5)
  park,
  @JsonValue(6)
  bar,
  @JsonValue(7)
  food,
  @JsonValue(8)
  other,
  @JsonValue(9)
  beforeParty,
}

@ContractsSerializable()
class SiteDTO with EquatableMixin {
  SiteDTO({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.category,
    this.photoUrl,
    this.gmapsPlaceId,
  });

  factory SiteDTO.fromJson(Map<String, dynamic> json) =>
      _$SiteDTOFromJson(json);

  final String id;

  final String name;

  final String address;

  final double latitude;

  final double longitude;

  final SiteCategoryDTO category;

  final String? photoUrl;

  final String? gmapsPlaceId;

  List<Object?> get props => [
    id,
    name,
    address,
    latitude,
    longitude,
    category,
    photoUrl,
    gmapsPlaceId,
  ];

  Map<String, dynamic> toJson() => _$SiteDTOToJson(this);
}

abstract class SortedQuery<TResult, TSort>
    with EquatableMixin
    implements PaginatedQuery<TResult> {
  SortedQuery({
    required this.pageNumber,
    required this.pageSize,
    required this.sortBy,
    required this.sortByDescending,
  });

  /// Zero-based.
  final int pageNumber;

  final int pageSize;

  final TSort sortBy;

  final bool sortByDescending;

  List<Object?> get props => [pageNumber, pageSize, sortBy, sortByDescending];
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class AllModerators with EquatableMixin implements Query<List<SpeakerDTO>> {
  AllModerators();

  factory AllModerators.fromJson(Map<String, dynamic> json) =>
      _$AllModeratorsFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$AllModeratorsToJson(this);

  List<SpeakerDTO> resultFactory(dynamic decodedJson) =>
      (decodedJson as Iterable<dynamic>)
          .map((dynamic e) => _$SpeakerDTOFromJson(e as Map<String, dynamic>))
          .toList();

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Speakers.AllModerators';
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class AllSpeakers with EquatableMixin implements Query<List<SpeakerDTO>> {
  AllSpeakers();

  factory AllSpeakers.fromJson(Map<String, dynamic> json) =>
      _$AllSpeakersFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$AllSpeakersToJson(this);

  List<SpeakerDTO> resultFactory(dynamic decodedJson) =>
      (decodedJson as Iterable<dynamic>)
          .map((dynamic e) => _$SpeakerDTOFromJson(e as Map<String, dynamic>))
          .toList();

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Speakers.AllSpeakers';
}

@ContractsSerializable()
class SpeakerDTO with EquatableMixin {
  SpeakerDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.companyName,
    this.jobTitle,
    this.photoUrl,
    this.linkedInUrl,
    this.bio,
    this.companyPhotoUrl,
  });

  factory SpeakerDTO.fromJson(Map<String, dynamic> json) =>
      _$SpeakerDTOFromJson(json);

  final String id;

  final String firstName;

  final String lastName;

  final String? companyName;

  final String? jobTitle;

  final Uri? photoUrl;

  final Uri? linkedInUrl;

  final String? bio;

  final Uri? companyPhotoUrl;

  List<Object?> get props => [
    id,
    firstName,
    lastName,
    companyName,
    jobTitle,
    photoUrl,
    linkedInUrl,
    bio,
    companyPhotoUrl,
  ];

  Map<String, dynamic> toJson() => _$SpeakerDTOToJson(this);
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class AllTracks with EquatableMixin implements PaginatedQuery<TrackSummaryDTO> {
  AllTracks({
    required this.pageNumber,
    required this.pageSize,
    required this.nameFilter,
    required this.hasSessionsOnly,
  });

  factory AllTracks.fromJson(Map<String, dynamic> json) =>
      _$AllTracksFromJson(json);

  /// Zero-based.
  final int pageNumber;

  final int pageSize;

  final String? nameFilter;

  final bool? hasSessionsOnly;

  List<Object?> get props => [
    pageNumber,
    pageSize,
    nameFilter,
    hasSessionsOnly,
  ];

  Map<String, dynamic> toJson() => _$AllTracksToJson(this);

  PaginatedResult<TrackSummaryDTO> resultFactory(dynamic decodedJson) =>
      _$PaginatedResultFromJson(
        decodedJson as Map<String, dynamic>,
        (e) => _$TrackSummaryDTOFromJson(e as Map<String, dynamic>),
      );

  String getFullName() => 'FlutterTechSummit.Core.Contracts.Tracks.AllTracks';
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('user')
@ContractsSerializable()
class AssignSessionToTrack with EquatableMixin implements Command {
  AssignSessionToTrack({required this.trackId, required this.sessionId});

  factory AssignSessionToTrack.fromJson(Map<String, dynamic> json) =>
      _$AssignSessionToTrackFromJson(json);

  final String trackId;

  final String sessionId;

  List<Object?> get props => [trackId, sessionId];

  Map<String, dynamic> toJson() => _$AssignSessionToTrackToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Tracks.AssignSessionToTrack';
}

class AssignSessionToTrackErrorCodes {
  static const trackIdIsInvalid = 1;

  static const trackDoesNotExist = 2;

  static const sessionIdIsInvalid = 3;

  static const sessionDoesNotExist = 4;

  static const sessionAlreadyAssignedToTrack = 5;

  static const dailySessionLimitExceeded = 6;
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class CreateTrack with EquatableMixin implements Command {
  CreateTrack({required this.name});

  factory CreateTrack.fromJson(Map<String, dynamic> json) =>
      _$CreateTrackFromJson(json);

  final String name;

  List<Object?> get props => [name];

  Map<String, dynamic> toJson() => _$CreateTrackToJson(this);

  String getFullName() => 'FlutterTechSummit.Core.Contracts.Tracks.CreateTrack';
}

class CreateTrackErrorCodes {
  static const nameIsNullOrEmpty = 1;

  static const nameIsTooLong = 2;
}

@ContractsSerializable()
class CreateTrackConsts with EquatableMixin {
  CreateTrackConsts();

  factory CreateTrackConsts.fromJson(Map<String, dynamic> json) =>
      _$CreateTrackConstsFromJson(json);

  static const int nameMaxLength = 200;

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$CreateTrackConstsToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class DeleteTrack with EquatableMixin implements Command {
  DeleteTrack({required this.trackId});

  factory DeleteTrack.fromJson(Map<String, dynamic> json) =>
      _$DeleteTrackFromJson(json);

  final String trackId;

  List<Object?> get props => [trackId];

  Map<String, dynamic> toJson() => _$DeleteTrackToJson(this);

  String getFullName() => 'FlutterTechSummit.Core.Contracts.Tracks.DeleteTrack';
}

class DeleteTrackErrorCodes {
  static const trackIdIsInvalid = 1;

  static const trackDoesNotExist = 2;
}

@ContractsSerializable()
class TrackDTO with EquatableMixin {
  TrackDTO({required this.id, required this.name, required this.sessions});

  factory TrackDTO.fromJson(Map<String, dynamic> json) =>
      _$TrackDTOFromJson(json);

  final String id;

  final String name;

  final List<TrackSessionDTO> sessions;

  List<Object?> get props => [id, name, sessions];

  Map<String, dynamic> toJson() => _$TrackDTOToJson(this);
}

/// LeanCode.Contracts.Security.AllowUnauthorizedAttribute()
@ContractsSerializable()
class TrackDetails with EquatableMixin implements Query<TrackDetailsDTO?> {
  TrackDetails({required this.trackId});

  factory TrackDetails.fromJson(Map<String, dynamic> json) =>
      _$TrackDetailsFromJson(json);

  final String trackId;

  List<Object?> get props => [trackId];

  Map<String, dynamic> toJson() => _$TrackDetailsToJson(this);

  TrackDetailsDTO? resultFactory(dynamic decodedJson) => decodedJson == null
      ? null
      : _$TrackDetailsDTOFromJson(decodedJson as Map<String, dynamic>);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Tracks.TrackDetails';
}

@ContractsSerializable()
class TrackDetailsDTO with EquatableMixin {
  TrackDetailsDTO({
    required this.id,
    required this.name,
    required this.sessions,
  });

  factory TrackDetailsDTO.fromJson(Map<String, dynamic> json) =>
      _$TrackDetailsDTOFromJson(json);

  final String id;

  final String name;

  final List<SessionDTO> sessions;

  List<Object?> get props => [id, name, sessions];

  Map<String, dynamic> toJson() => _$TrackDetailsDTOToJson(this);
}

@ContractsSerializable()
class TrackSessionDTO with EquatableMixin {
  TrackSessionDTO({
    required this.sessionId,
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.day,
  });

  factory TrackSessionDTO.fromJson(Map<String, dynamic> json) =>
      _$TrackSessionDTOFromJson(json);

  final String sessionId;

  final String title;

  final SessionTypeDTO type;

  final DateTimeOffset startDate;

  final DateTimeOffset endDate;

  final DateOnly day;

  List<Object?> get props => [sessionId, title, type, startDate, endDate, day];

  Map<String, dynamic> toJson() => _$TrackSessionDTOToJson(this);
}

@ContractsSerializable()
class TrackSummaryDTO with EquatableMixin {
  TrackSummaryDTO({
    required this.id,
    required this.name,
    required this.sessionCount,
  });

  factory TrackSummaryDTO.fromJson(Map<String, dynamic> json) =>
      _$TrackSummaryDTOFromJson(json);

  final String id;

  final String name;

  final int sessionCount;

  List<Object?> get props => [id, name, sessionCount];

  Map<String, dynamic> toJson() => _$TrackSummaryDTOToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class UnassignSessionFromTrack with EquatableMixin implements Command {
  UnassignSessionFromTrack({required this.trackId, required this.sessionId});

  factory UnassignSessionFromTrack.fromJson(Map<String, dynamic> json) =>
      _$UnassignSessionFromTrackFromJson(json);

  final String trackId;

  final String sessionId;

  List<Object?> get props => [trackId, sessionId];

  Map<String, dynamic> toJson() => _$UnassignSessionFromTrackToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Tracks.UnassignSessionFromTrack';
}

class UnassignSessionFromTrackErrorCodes {
  static const trackIdIsInvalid = 1;

  static const trackDoesNotExist = 2;

  static const sessionIdIsInvalid = 3;
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('admin')
@ContractsSerializable()
class UpdateTrack with EquatableMixin implements Command {
  UpdateTrack({required this.trackId, required this.name});

  factory UpdateTrack.fromJson(Map<String, dynamic> json) =>
      _$UpdateTrackFromJson(json);

  final String trackId;

  final String name;

  List<Object?> get props => [trackId, name];

  Map<String, dynamic> toJson() => _$UpdateTrackToJson(this);

  String getFullName() => 'FlutterTechSummit.Core.Contracts.Tracks.UpdateTrack';
}

class UpdateTrackErrorCodes {
  static const trackIdIsInvalid = 1;

  static const trackDoesNotExist = 2;

  static const nameIsNullOrEmpty = 3;

  static const nameIsTooLong = 4;
}

@ContractsSerializable()
class UpdateTrackConsts with EquatableMixin {
  UpdateTrackConsts();

  factory UpdateTrackConsts.fromJson(Map<String, dynamic> json) =>
      _$UpdateTrackConstsFromJson(json);

  static const int nameMaxLength = 200;

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$UpdateTrackConstsToJson(this);
}

/// LeanCode.Contracts.Security.AuthorizeWhenHasAnyOfAttribute('user')
@ContractsSerializable()
class DeleteOwnAccount with EquatableMixin implements Command {
  DeleteOwnAccount();

  factory DeleteOwnAccount.fromJson(Map<String, dynamic> json) =>
      _$DeleteOwnAccountFromJson(json);

  List<Object?> get props => [];

  Map<String, dynamic> toJson() => _$DeleteOwnAccountToJson(this);

  String getFullName() =>
      'FlutterTechSummit.Core.Contracts.Users.DeleteOwnAccount';
}

class DeleteOwnAccountErrorCodes {}

@ContractsSerializable(genericArgumentFactories: true)
class AdminFilterRange<T> with EquatableMixin {
  AdminFilterRange({this.from, this.to});

  factory AdminFilterRange.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$AdminFilterRangeFromJson(json, fromJsonT);

  final T? from;

  final T? to;

  List<Object?> get props => [from, to];
}

abstract class AdminQuery<TResult>
    with EquatableMixin
    implements Query<AdminQueryResult<TResult>> {
  AdminQuery({
    required this.page,
    required this.pageSize,
    this.sortDescending,
    this.sortBy,
  });

  /// 0-based
  final int page;

  final int pageSize;

  final bool? sortDescending;

  final String? sortBy;

  List<Object?> get props => [page, pageSize, sortDescending, sortBy];
}

@ContractsSerializable(genericArgumentFactories: true)
class AdminQueryResult<TResult> with EquatableMixin {
  AdminQueryResult({required this.total, required this.items});

  factory AdminQueryResult.fromJson(
    Map<String, dynamic> json,
    TResult Function(Object?) fromJsonTResult,
  ) => _$AdminQueryResultFromJson(json, fromJsonTResult);

  final int total;

  final List<TResult> items;

  List<Object?> get props => [total, items];
}

enum PlatformDTO {
  @JsonValue(0)
  android,
  @JsonValue(1)
  ios,
}

@ContractsSerializable()
class VersionSupport with EquatableMixin implements Query<VersionSupportDTO> {
  VersionSupport({required this.platform, required this.version});

  factory VersionSupport.fromJson(Map<String, dynamic> json) =>
      _$VersionSupportFromJson(json);

  final PlatformDTO platform;

  final String version;

  List<Object?> get props => [platform, version];

  Map<String, dynamic> toJson() => _$VersionSupportToJson(this);

  VersionSupportDTO resultFactory(dynamic decodedJson) =>
      _$VersionSupportDTOFromJson(decodedJson as Map<String, dynamic>);

  String getFullName() => 'LeanCode.ForceUpdate.Contracts.VersionSupport';
}

@ContractsSerializable()
class VersionSupportDTO with EquatableMixin {
  VersionSupportDTO({
    required this.currentlySupportedVersion,
    required this.minimumRequiredVersion,
    required this.result,
  });

  factory VersionSupportDTO.fromJson(Map<String, dynamic> json) =>
      _$VersionSupportDTOFromJson(json);

  final String currentlySupportedVersion;

  final String minimumRequiredVersion;

  final VersionSupportResultDTO result;

  List<Object?> get props => [
    currentlySupportedVersion,
    minimumRequiredVersion,
    result,
  ];

  Map<String, dynamic> toJson() => _$VersionSupportDTOToJson(this);
}

enum VersionSupportResultDTO {
  @JsonValue(0)
  updateRequired,
  @JsonValue(1)
  updateSuggested,
  @JsonValue(2)
  upToDate,
}

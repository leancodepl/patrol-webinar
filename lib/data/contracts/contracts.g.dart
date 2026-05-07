// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth();

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{};

KnownClaims _$KnownClaimsFromJson(Map<String, dynamic> json) => KnownClaims();

Map<String, dynamic> _$KnownClaimsToJson(KnownClaims instance) =>
    <String, dynamic>{};

Roles _$RolesFromJson(Map<String, dynamic> json) => Roles();

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{};

KratosIdentityDTO _$KratosIdentityDTOFromJson(Map<String, dynamic> json) =>
    KratosIdentityDTO(
      id: json['Id'] as String,
      createdAt: DateTimeOffset.fromJson(json['CreatedAt'] as String),
      updatedAt: DateTimeOffset.fromJson(json['UpdatedAt'] as String),
      schemaId: json['SchemaId'] as String,
      email: json['Email'] as String,
    );

Map<String, dynamic> _$KratosIdentityDTOToJson(KratosIdentityDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'SchemaId': instance.schemaId,
      'Email': instance.email,
    };

SearchIdentities _$SearchIdentitiesFromJson(Map<String, dynamic> json) =>
    SearchIdentities(
      pageNumber: (json['PageNumber'] as num).toInt(),
      pageSize: (json['PageSize'] as num).toInt(),
      schemaId: json['SchemaId'] as String?,
      emailPattern: json['EmailPattern'] as String?,
      givenNamePattern: json['GivenNamePattern'] as String?,
      familyNamePattern: json['FamilyNamePattern'] as String?,
    );

Map<String, dynamic> _$SearchIdentitiesToJson(SearchIdentities instance) =>
    <String, dynamic>{
      'PageNumber': instance.pageNumber,
      'PageSize': instance.pageSize,
      'SchemaId': instance.schemaId,
      'EmailPattern': instance.emailPattern,
      'GivenNamePattern': instance.givenNamePattern,
      'FamilyNamePattern': instance.familyNamePattern,
    };

CustomMessagePayload _$CustomMessagePayloadFromJson(
  Map<String, dynamic> json,
) => CustomMessagePayload(
  title: json['Title'] as String,
  content: json['Content'] as String,
  deepLink: json['DeepLink'] as String?,
);

Map<String, dynamic> _$CustomMessagePayloadToJson(
  CustomMessagePayload instance,
) => <String, dynamic>{
  'Title': instance.title,
  'Content': instance.content,
  'DeepLink': instance.deepLink,
};

NotificationCenterToken _$NotificationCenterTokenFromJson(
  Map<String, dynamic> json,
) => NotificationCenterToken();

Map<String, dynamic> _$NotificationCenterTokenToJson(
  NotificationCenterToken instance,
) => <String, dynamic>{};

SendCustomMessage _$SendCustomMessageFromJson(Map<String, dynamic> json) =>
    SendCustomMessage(
      title: json['Title'] as String,
      content: json['Content'] as String,
      deepLink: json['DeepLink'] as String?,
      notificationToken: json['NotificationToken'] as String?,
    );

Map<String, dynamic> _$SendCustomMessageToJson(SendCustomMessage instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Content': instance.content,
      'DeepLink': instance.deepLink,
      'NotificationToken': instance.notificationToken,
    };

SendSessionStartingMessage _$SendSessionStartingMessageFromJson(
  Map<String, dynamic> json,
) => SendSessionStartingMessage(
  sessionId: json['SessionId'] as String,
  title: json['Title'] as String,
  content: json['Content'] as String,
  notificationToken: json['NotificationToken'] as String?,
);

Map<String, dynamic> _$SendSessionStartingMessageToJson(
  SendSessionStartingMessage instance,
) => <String, dynamic>{
  'SessionId': instance.sessionId,
  'Title': instance.title,
  'Content': instance.content,
  'NotificationToken': instance.notificationToken,
};

SessionStartingMessagePayload _$SessionStartingMessagePayloadFromJson(
  Map<String, dynamic> json,
) => SessionStartingMessagePayload(
  sessionId: json['SessionId'] as String,
  title: json['Title'] as String,
  content: json['Content'] as String,
);

Map<String, dynamic> _$SessionStartingMessagePayloadToJson(
  SessionStartingMessagePayload instance,
) => <String, dynamic>{
  'SessionId': instance.sessionId,
  'Title': instance.title,
  'Content': instance.content,
};

PaginatedResult<TResult> _$PaginatedResultFromJson<TResult>(
  Map<String, dynamic> json,
  TResult Function(Object? json) fromJsonTResult,
) => PaginatedResult<TResult>(
  items: (json['Items'] as List<dynamic>).map(fromJsonTResult).toList(),
  totalCount: (json['TotalCount'] as num).toInt(),
);

Map<String, dynamic> _$PaginatedResultToJson<TResult>(
  PaginatedResult<TResult> instance,
  Object? Function(TResult value) toJsonTResult,
) => <String, dynamic>{
  'Items': instance.items.map(toJsonTResult).toList(),
  'TotalCount': instance.totalCount,
};

Agenda _$AgendaFromJson(Map<String, dynamic> json) => Agenda();

Map<String, dynamic> _$AgendaToJson(Agenda instance) => <String, dynamic>{};

EditAgenda _$EditAgendaFromJson(Map<String, dynamic> json) => EditAgenda(
  sessions: (json['Sessions'] as List<dynamic>)
      .map((e) => EditAgendaSessionDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EditAgendaToJson(EditAgenda instance) =>
    <String, dynamic>{'Sessions': instance.sessions};

EditAgendaRoundtableSlotDTO _$EditAgendaRoundtableSlotDTOFromJson(
  Map<String, dynamic> json,
) => EditAgendaRoundtableSlotDTO(
  topic: json['Topic'] as String,
  description: json['Description'] as String?,
  moderatorId: json['ModeratorId'] as String,
);

Map<String, dynamic> _$EditAgendaRoundtableSlotDTOToJson(
  EditAgendaRoundtableSlotDTO instance,
) => <String, dynamic>{
  'Topic': instance.topic,
  'Description': instance.description,
  'ModeratorId': instance.moderatorId,
};

EditAgendaSessionDTO _$EditAgendaSessionDTOFromJson(
  Map<String, dynamic> json,
) => EditAgendaSessionDTO(
  id: json['Id'] as String,
  title: json['Title'] as String,
  description: json['Description'] as String?,
  startDate: DateTimeOffset.fromJson(json['StartDate'] as String),
  endDate: DateTimeOffset.fromJson(json['EndDate'] as String),
  type: $enumDecode(_$SessionTypeDTOEnumMap, json['Type']),
  speakerIds: (json['SpeakerIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  siteId: json['SiteId'] as String?,
  roundtableSlots: (json['RoundtableSlots'] as List<dynamic>?)
      ?.map(
        (e) => EditAgendaRoundtableSlotDTO.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$EditAgendaSessionDTOToJson(
  EditAgendaSessionDTO instance,
) => <String, dynamic>{
  'Id': instance.id,
  'Title': instance.title,
  'Description': instance.description,
  'StartDate': instance.startDate,
  'EndDate': instance.endDate,
  'Type': _$SessionTypeDTOEnumMap[instance.type]!,
  'SpeakerIds': instance.speakerIds,
  'SiteId': instance.siteId,
  'RoundtableSlots': instance.roundtableSlots,
};

const _$SessionTypeDTOEnumMap = {
  SessionTypeDTO.talk: 0,
  SessionTypeDTO.roundtable: 1,
  SessionTypeDTO.other: 2,
};

RateSession _$RateSessionFromJson(Map<String, dynamic> json) => RateSession(
  sessionId: json['SessionId'] as String,
  rating: (json['Rating'] as num).toInt(),
  comment: json['Comment'] as String?,
);

Map<String, dynamic> _$RateSessionToJson(RateSession instance) =>
    <String, dynamic>{
      'SessionId': instance.sessionId,
      'Rating': instance.rating,
      'Comment': instance.comment,
    };

RatingDTO _$RatingDTOFromJson(Map<String, dynamic> json) => RatingDTO(
  rating: (json['Rating'] as num).toInt(),
  comment: json['Comment'] as String?,
);

Map<String, dynamic> _$RatingDTOToJson(RatingDTO instance) => <String, dynamic>{
  'Rating': instance.rating,
  'Comment': instance.comment,
};

RoundtableSlotDTO _$RoundtableSlotDTOFromJson(Map<String, dynamic> json) =>
    RoundtableSlotDTO(
      topic: json['Topic'] as String,
      description: json['Description'] as String?,
      moderator: SpeakerDTO.fromJson(json['Moderator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoundtableSlotDTOToJson(RoundtableSlotDTO instance) =>
    <String, dynamic>{
      'Topic': instance.topic,
      'Description': instance.description,
      'Moderator': instance.moderator,
    };

SessionDTO _$SessionDTOFromJson(Map<String, dynamic> json) => SessionDTO(
  id: json['Id'] as String,
  title: json['Title'] as String,
  description: json['Description'] as String?,
  startDate: DateTimeOffset.fromJson(json['StartDate'] as String),
  endDate: DateTimeOffset.fromJson(json['EndDate'] as String),
  day: DateOnly.fromJson(json['Day'] as String),
  type: $enumDecode(_$SessionTypeDTOEnumMap, json['Type']),
  speakers: (json['Speakers'] as List<dynamic>)
      .map((e) => SpeakerDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  roundtableSlots: (json['RoundtableSlots'] as List<dynamic>?)
      ?.map((e) => RoundtableSlotDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  site: json['Site'] == null
      ? null
      : SiteDTO.fromJson(json['Site'] as Map<String, dynamic>),
  userRating: json['UserRating'] == null
      ? null
      : RatingDTO.fromJson(json['UserRating'] as Map<String, dynamic>),
  tracks: (json['Tracks'] as List<dynamic>)
      .map((e) => SessionTrackDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SessionDTOToJson(SessionDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Description': instance.description,
      'StartDate': instance.startDate,
      'EndDate': instance.endDate,
      'Day': instance.day,
      'Type': _$SessionTypeDTOEnumMap[instance.type]!,
      'Speakers': instance.speakers,
      'RoundtableSlots': instance.roundtableSlots,
      'Site': instance.site,
      'UserRating': instance.userRating,
      'Tracks': instance.tracks,
    };

SessionTrackDTO _$SessionTrackDTOFromJson(Map<String, dynamic> json) =>
    SessionTrackDTO(id: json['Id'] as String, name: json['Name'] as String);

Map<String, dynamic> _$SessionTrackDTOToJson(SessionTrackDTO instance) =>
    <String, dynamic>{'Id': instance.id, 'Name': instance.name};

AllSites _$AllSitesFromJson(Map<String, dynamic> json) => AllSites();

Map<String, dynamic> _$AllSitesToJson(AllSites instance) => <String, dynamic>{};

SiteDTO _$SiteDTOFromJson(Map<String, dynamic> json) => SiteDTO(
  id: json['Id'] as String,
  name: json['Name'] as String,
  address: json['Address'] as String,
  latitude: (json['Latitude'] as num).toDouble(),
  longitude: (json['Longitude'] as num).toDouble(),
  category: $enumDecode(_$SiteCategoryDTOEnumMap, json['Category']),
  photoUrl: json['PhotoUrl'] as String?,
  gmapsPlaceId: json['GmapsPlaceId'] as String?,
);

Map<String, dynamic> _$SiteDTOToJson(SiteDTO instance) => <String, dynamic>{
  'Id': instance.id,
  'Name': instance.name,
  'Address': instance.address,
  'Latitude': instance.latitude,
  'Longitude': instance.longitude,
  'Category': _$SiteCategoryDTOEnumMap[instance.category]!,
  'PhotoUrl': instance.photoUrl,
  'GmapsPlaceId': instance.gmapsPlaceId,
};

const _$SiteCategoryDTOEnumMap = {
  SiteCategoryDTO.event: 0,
  SiteCategoryDTO.afterParty: 1,
  SiteCategoryDTO.leanCodeOffice: 2,
  SiteCategoryDTO.cultural: 3,
  SiteCategoryDTO.museum: 4,
  SiteCategoryDTO.park: 5,
  SiteCategoryDTO.bar: 6,
  SiteCategoryDTO.food: 7,
  SiteCategoryDTO.other: 8,
  SiteCategoryDTO.beforeParty: 9,
};

AllModerators _$AllModeratorsFromJson(Map<String, dynamic> json) =>
    AllModerators();

Map<String, dynamic> _$AllModeratorsToJson(AllModerators instance) =>
    <String, dynamic>{};

AllSpeakers _$AllSpeakersFromJson(Map<String, dynamic> json) => AllSpeakers();

Map<String, dynamic> _$AllSpeakersToJson(AllSpeakers instance) =>
    <String, dynamic>{};

SpeakerDTO _$SpeakerDTOFromJson(Map<String, dynamic> json) => SpeakerDTO(
  id: json['Id'] as String,
  firstName: json['FirstName'] as String,
  lastName: json['LastName'] as String,
  companyName: json['CompanyName'] as String?,
  jobTitle: json['JobTitle'] as String?,
  photoUrl: json['PhotoUrl'] == null
      ? null
      : Uri.parse(json['PhotoUrl'] as String),
  linkedInUrl: json['LinkedInUrl'] == null
      ? null
      : Uri.parse(json['LinkedInUrl'] as String),
  bio: json['Bio'] as String?,
  companyPhotoUrl: json['CompanyPhotoUrl'] == null
      ? null
      : Uri.parse(json['CompanyPhotoUrl'] as String),
);

Map<String, dynamic> _$SpeakerDTOToJson(SpeakerDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'CompanyName': instance.companyName,
      'JobTitle': instance.jobTitle,
      'PhotoUrl': instance.photoUrl?.toString(),
      'LinkedInUrl': instance.linkedInUrl?.toString(),
      'Bio': instance.bio,
      'CompanyPhotoUrl': instance.companyPhotoUrl?.toString(),
    };

AllTracks _$AllTracksFromJson(Map<String, dynamic> json) => AllTracks(
  pageNumber: (json['PageNumber'] as num).toInt(),
  pageSize: (json['PageSize'] as num).toInt(),
  nameFilter: json['NameFilter'] as String?,
  hasSessionsOnly: json['HasSessionsOnly'] as bool?,
);

Map<String, dynamic> _$AllTracksToJson(AllTracks instance) => <String, dynamic>{
  'PageNumber': instance.pageNumber,
  'PageSize': instance.pageSize,
  'NameFilter': instance.nameFilter,
  'HasSessionsOnly': instance.hasSessionsOnly,
};

AssignSessionToTrack _$AssignSessionToTrackFromJson(
  Map<String, dynamic> json,
) => AssignSessionToTrack(
  trackId: json['TrackId'] as String,
  sessionId: json['SessionId'] as String,
);

Map<String, dynamic> _$AssignSessionToTrackToJson(
  AssignSessionToTrack instance,
) => <String, dynamic>{
  'TrackId': instance.trackId,
  'SessionId': instance.sessionId,
};

CreateTrack _$CreateTrackFromJson(Map<String, dynamic> json) =>
    CreateTrack(name: json['Name'] as String);

Map<String, dynamic> _$CreateTrackToJson(CreateTrack instance) =>
    <String, dynamic>{'Name': instance.name};

CreateTrackConsts _$CreateTrackConstsFromJson(Map<String, dynamic> json) =>
    CreateTrackConsts();

Map<String, dynamic> _$CreateTrackConstsToJson(CreateTrackConsts instance) =>
    <String, dynamic>{};

DeleteTrack _$DeleteTrackFromJson(Map<String, dynamic> json) =>
    DeleteTrack(trackId: json['TrackId'] as String);

Map<String, dynamic> _$DeleteTrackToJson(DeleteTrack instance) =>
    <String, dynamic>{'TrackId': instance.trackId};

TrackDTO _$TrackDTOFromJson(Map<String, dynamic> json) => TrackDTO(
  id: json['Id'] as String,
  name: json['Name'] as String,
  sessions: (json['Sessions'] as List<dynamic>)
      .map((e) => TrackSessionDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TrackDTOToJson(TrackDTO instance) => <String, dynamic>{
  'Id': instance.id,
  'Name': instance.name,
  'Sessions': instance.sessions,
};

TrackDetails _$TrackDetailsFromJson(Map<String, dynamic> json) =>
    TrackDetails(trackId: json['TrackId'] as String);

Map<String, dynamic> _$TrackDetailsToJson(TrackDetails instance) =>
    <String, dynamic>{'TrackId': instance.trackId};

TrackDetailsDTO _$TrackDetailsDTOFromJson(Map<String, dynamic> json) =>
    TrackDetailsDTO(
      id: json['Id'] as String,
      name: json['Name'] as String,
      sessions: (json['Sessions'] as List<dynamic>)
          .map((e) => SessionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackDetailsDTOToJson(TrackDetailsDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Sessions': instance.sessions,
    };

TrackSessionDTO _$TrackSessionDTOFromJson(Map<String, dynamic> json) =>
    TrackSessionDTO(
      sessionId: json['SessionId'] as String,
      title: json['Title'] as String,
      type: $enumDecode(_$SessionTypeDTOEnumMap, json['Type']),
      startDate: DateTimeOffset.fromJson(json['StartDate'] as String),
      endDate: DateTimeOffset.fromJson(json['EndDate'] as String),
      day: DateOnly.fromJson(json['Day'] as String),
    );

Map<String, dynamic> _$TrackSessionDTOToJson(TrackSessionDTO instance) =>
    <String, dynamic>{
      'SessionId': instance.sessionId,
      'Title': instance.title,
      'Type': _$SessionTypeDTOEnumMap[instance.type]!,
      'StartDate': instance.startDate,
      'EndDate': instance.endDate,
      'Day': instance.day,
    };

TrackSummaryDTO _$TrackSummaryDTOFromJson(Map<String, dynamic> json) =>
    TrackSummaryDTO(
      id: json['Id'] as String,
      name: json['Name'] as String,
      sessionCount: (json['SessionCount'] as num).toInt(),
    );

Map<String, dynamic> _$TrackSummaryDTOToJson(TrackSummaryDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'SessionCount': instance.sessionCount,
    };

UnassignSessionFromTrack _$UnassignSessionFromTrackFromJson(
  Map<String, dynamic> json,
) => UnassignSessionFromTrack(
  trackId: json['TrackId'] as String,
  sessionId: json['SessionId'] as String,
);

Map<String, dynamic> _$UnassignSessionFromTrackToJson(
  UnassignSessionFromTrack instance,
) => <String, dynamic>{
  'TrackId': instance.trackId,
  'SessionId': instance.sessionId,
};

UpdateTrack _$UpdateTrackFromJson(Map<String, dynamic> json) => UpdateTrack(
  trackId: json['TrackId'] as String,
  name: json['Name'] as String,
);

Map<String, dynamic> _$UpdateTrackToJson(UpdateTrack instance) =>
    <String, dynamic>{'TrackId': instance.trackId, 'Name': instance.name};

UpdateTrackConsts _$UpdateTrackConstsFromJson(Map<String, dynamic> json) =>
    UpdateTrackConsts();

Map<String, dynamic> _$UpdateTrackConstsToJson(UpdateTrackConsts instance) =>
    <String, dynamic>{};

DeleteOwnAccount _$DeleteOwnAccountFromJson(Map<String, dynamic> json) =>
    DeleteOwnAccount();

Map<String, dynamic> _$DeleteOwnAccountToJson(DeleteOwnAccount instance) =>
    <String, dynamic>{};

AdminFilterRange<T> _$AdminFilterRangeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => AdminFilterRange<T>(
  from: _$nullableGenericFromJson(json['From'], fromJsonT),
  to: _$nullableGenericFromJson(json['To'], fromJsonT),
);

Map<String, dynamic> _$AdminFilterRangeToJson<T>(
  AdminFilterRange<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'From': _$nullableGenericToJson(instance.from, toJsonT),
  'To': _$nullableGenericToJson(instance.to, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

AdminQueryResult<TResult> _$AdminQueryResultFromJson<TResult>(
  Map<String, dynamic> json,
  TResult Function(Object? json) fromJsonTResult,
) => AdminQueryResult<TResult>(
  total: (json['Total'] as num).toInt(),
  items: (json['Items'] as List<dynamic>).map(fromJsonTResult).toList(),
);

Map<String, dynamic> _$AdminQueryResultToJson<TResult>(
  AdminQueryResult<TResult> instance,
  Object? Function(TResult value) toJsonTResult,
) => <String, dynamic>{
  'Total': instance.total,
  'Items': instance.items.map(toJsonTResult).toList(),
};

VersionSupport _$VersionSupportFromJson(Map<String, dynamic> json) =>
    VersionSupport(
      platform: $enumDecode(_$PlatformDTOEnumMap, json['Platform']),
      version: json['Version'] as String,
    );

Map<String, dynamic> _$VersionSupportToJson(VersionSupport instance) =>
    <String, dynamic>{
      'Platform': _$PlatformDTOEnumMap[instance.platform]!,
      'Version': instance.version,
    };

const _$PlatformDTOEnumMap = {PlatformDTO.android: 0, PlatformDTO.ios: 1};

VersionSupportDTO _$VersionSupportDTOFromJson(Map<String, dynamic> json) =>
    VersionSupportDTO(
      currentlySupportedVersion: json['CurrentlySupportedVersion'] as String,
      minimumRequiredVersion: json['MinimumRequiredVersion'] as String,
      result: $enumDecode(_$VersionSupportResultDTOEnumMap, json['Result']),
    );

Map<String, dynamic> _$VersionSupportDTOToJson(VersionSupportDTO instance) =>
    <String, dynamic>{
      'CurrentlySupportedVersion': instance.currentlySupportedVersion,
      'MinimumRequiredVersion': instance.minimumRequiredVersion,
      'Result': _$VersionSupportResultDTOEnumMap[instance.result]!,
    };

const _$VersionSupportResultDTOEnumMap = {
  VersionSupportResultDTO.updateRequired: 0,
  VersionSupportResultDTO.updateSuggested: 1,
  VersionSupportResultDTO.upToDate: 2,
};

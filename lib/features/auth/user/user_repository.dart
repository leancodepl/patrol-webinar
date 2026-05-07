import 'package:cached_query/cached_query.dart';
import 'package:leancode_kratos_client/leancode_kratos_client.dart';

class UserRepository {
  UserRepository({required KratosClient kratosClient})
    : _kratosClient = kratosClient {
    query = Query<UserProfile>(
      key: 'get-user',
      queryFn: () async {
        final result = await _kratosClient.getUserProfile();
        return result;
      },
      onSuccess: (userProfile) => _cachedUser = userProfile,
    );
  }

  final KratosClient _kratosClient;
  late final Query<UserProfile> query;

  UserProfile? _cachedUser;

  Future<String?> getUserId() async {
    if (_cachedUser case final UserProfileData user?) {
      return user.userId;
    }

    final user = await getUser();
    if (user case UserProfileData(:final userId)) {
      return userId;
    }
    return null;
  }

  Future<UserProfile> getUser() async {
    _cachedUser = await _kratosClient.getUserProfile();
    return _cachedUser!;
  }
}

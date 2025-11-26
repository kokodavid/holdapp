

import '../../../core/error/exceptions.dart';
import '../../models/auth/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getLastUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  UserModel? _cachedUser;

  @override
  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearCache() async {
    _cachedUser = null;
  }

  @override
  Future<UserModel?> getLastUser() async {
    if (_cachedUser == null) throw CacheException('No cached user');
    return _cachedUser;
  }
}

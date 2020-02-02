import 'package:meta/meta.dart';

/// A service which authenciates a user
abstract class IAuthService {
  /// Attempts to create a new user with a given email and password combination
  Future<bool> createUserAccount({@required email, @required password});

  /// Attempts to login a user with a given email and password combination
  Future<bool> login({@required email, @required password});

  /// Attempts to logout a user
  Future<void> logout();
}

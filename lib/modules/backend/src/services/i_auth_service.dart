import 'package:meta/meta.dart';

/// A service which authenciates a user
abstract class IAuthService {
  /// Attempts to login a user with a given email and password combination
  Future<bool> login({@required email, @required password});

  /// Attempts to logout a user
  Future<bool> logout();
}

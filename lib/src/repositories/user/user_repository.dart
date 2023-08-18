import 'package:agendador_dw11/src/core/exceptions/auth_exception.dart';
import 'package:agendador_dw11/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}

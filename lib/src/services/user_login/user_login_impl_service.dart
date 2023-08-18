import 'package:agendador_dw11/src/core/constants/local_storage_keys.dart';
import 'package:agendador_dw11/src/core/exceptions/auth_exception.dart';
import 'package:agendador_dw11/src/core/exceptions/service_exception.dart';
import 'package:agendador_dw11/src/core/fp/either.dart';
import 'package:agendador_dw11/src/core/fp/nil.dart';
import 'package:agendador_dw11/src/repositories/user/user_repository.dart';
import 'package:agendador_dw11/src/services/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({
    required this.userRepository,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);

        return Success(nil);
      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(ServiceException(message: 'Erro ao realizar login'));
          case AuthUnauthorizedException():
            return Failure(
                ServiceException(message: 'Login ou Senha inválidos'));
        }
    }
  }
}

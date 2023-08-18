import 'package:agendador_dw11/src/core/exceptions/service_exception.dart';
import 'package:agendador_dw11/src/core/fp/either.dart';
import 'package:agendador_dw11/src/core/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}

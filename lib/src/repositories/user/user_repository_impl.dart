import 'dart:developer';
import 'dart:io';

import 'package:agendador_dw11/src/core/exceptions/auth_exception.dart';
import 'package:agendador_dw11/src/core/fp/either.dart';
import 'package:agendador_dw11/src/core/restClient/rest_client.dart';
import 'package:agendador_dw11/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );
      return Success(data['acess_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou Senha Inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }

      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }
}

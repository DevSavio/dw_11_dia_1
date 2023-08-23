import 'package:agendador_dw11/src/core/exceptions/service_exception.dart';
import 'package:agendador_dw11/src/core/fp/either.dart';
import 'package:agendador_dw11/src/core/providers/application_providers.dart';
import 'package:agendador_dw11/src/features/auth/login/login_state.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    final loaderHandle = AsyncLoaderHandler()..start();

    switch (result) {
      case Success():
        // buscar dados do usuario logado
        // fazer uma analise para qual o tipo do login
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
      //
    }
    loaderHandle.close();
  }
}

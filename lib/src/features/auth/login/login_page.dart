import 'package:agendador_dw11/src/features/auth/login/login_state.dart';
import 'package:agendador_dw11/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/form_helper.dart';
import '../../../core/ui/helpers/messages.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
          break;
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar login', context);
          break;
        case LoginState(status: LoginStateStatus.admLogin):
          break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          break;
      }
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 187, 203),
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/studioPascoal.jpg',
              ),
              fit: BoxFit.cover,
              opacity: 0.095,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/info_studio.jpg',
                            width: 200,
                            height: 120,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus,
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('E-mail inválido')
                            ]),
                            controller: emailEC,
                            decoration: const InputDecoration(
                              label: Text("Email:"),
                              hintText: 'Email: ',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black54),
                              hintStyle: TextStyle(color: Colors.black54),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          TextFormField(
                            onTapOutside: (_) => context.unfocus,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6,
                                  'Senha deve conter no mínimo 6 caracteres'),
                            ]),
                            obscureText: true,
                            controller: passwordEC,
                            decoration: const InputDecoration(
                              label: Text("Senha:"),
                              hintText: 'Senha: ',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black54),
                              hintStyle: TextStyle(color: Colors.black54),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Esqueceu a senha?",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                      "Campos inválidos", context);
                                  break;
                                case true:
                                  login(emailEC.text, passwordEC.text);
                              }
                            },
                            child: const Text(
                              "ACESSAR",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Criar Conta",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.deepPurple.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

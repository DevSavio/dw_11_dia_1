import 'package:agendador_dw11/src/core/ui/agendador_theme.dart';
import 'package:agendador_dw11/src/core/ui/widgets/agendador_loader.dart';
import 'package:agendador_dw11/src/features/auth/login/login_page.dart';
import 'package:agendador_dw11/src/features/splash/splash_page.dart';
import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';

class AgendadorApp extends StatelessWidget {
  const AgendadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const AgendadorLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "DW AGENDADOR",
          navigatorObservers: [asyncNavigatorObserver],
          theme: AgendadorTheme.themeData,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage()
          },
        );
      },
    );
  }
}

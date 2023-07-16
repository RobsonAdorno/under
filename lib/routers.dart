import 'package:flutter/widgets.dart';
import 'package:under/feature/home/presentation/page/home_logged_page.dart';

import 'feature/authentication/bussiness/bloc/sign_in_bloc.dart';
import 'feature/authentication/presentation/page/signin_page.dart';
import 'feature/home/bussiness/bloc/home_logged_bloc.dart';
import 'feature/pages/authentication/signup.dart';
import 'feature/pages/page.dart';

class Routers {
  static String initial = '/';
  static String signIn = '/signin';
  static String signUp = '/signup';
  static String mainPage = '/main';
  static String homeLogged = '/homeLogged';

  static Map<String, WidgetBuilder> allRouters() {
    return {
      initial: (_) => const HomePage(),
      signIn: (_) => SignInPage(
            signInBloc: getIt.get<SignInBloc>(),
          ),
      signUp: (_) => const SignUp(),
      mainPage: (_) => const MainPage(),
      homeLogged: (_) =>
          HomeLogged(homeLoggeddBloc: getIt.get<HomeLoggeddBloc>())
    };
  }
}

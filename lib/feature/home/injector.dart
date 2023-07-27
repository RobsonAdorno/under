import 'package:get_it/get_it.dart';
import 'package:under/feature/authentication/bussiness/bloc/sign_in_bloc.dart';
import 'package:under/feature/authentication/presentation/page/signin_page.dart';

import '../api/repository/authentication_repository.dart';
import '../api/service/auth_service.dart';
import '../authentication/bussiness/repository/i_auth_repository.dart';
import '../authentication/data/auth_repository.dart';
import '../reducers/sign_in_reducer.dart';
import '../reducers/sign_up_reducer.dart';
import 'bussiness/bloc/home_logged_bloc.dart';
import 'data/repository/home_logged_repository.dart';
import 'presentation/page/home_logged_page.dart';

class Injector {
  static GetIt getIt = GetIt.instance;
  static SignInReducer? reducer;
  static SignUpReducer? signUpReducer;

  static init() {
    getIt.registerSingleton<AuthenticationRepository>(
        AuthenticationRepository());
    getIt.registerSingleton<AuthService>(
        AuthService(getIt.get<AuthenticationRepository>()));
  }

  static initHomeModule() {
    getIt.registerSingleton<HomeLoggedRepository>(HomeLoggedRepository());
    getIt.registerSingleton<HomeLoggeddBloc>(HomeLoggeddBloc(
        homeLoggedRepository: getIt.get<HomeLoggedRepository>()));
    getIt.registerSingleton<HomeLogged>(
        HomeLogged(homeLoggeddBloc: getIt.get<HomeLoggeddBloc>()));
  }

  static initSignInModule() {
    getIt.registerSingleton<IAuthRepository>(AuthRepository());
    getIt.registerSingleton<SignInBloc>(
        SignInBloc(authRepository: getIt.get<IAuthRepository>()));
    getIt.registerSingleton(SignInPage(signInBloc: getIt.get<SignInBloc>()));
  }

  static void initReducer() {
    // reducer = SignInReducer(getIt.get<AuthService>());
    signUpReducer = SignUpReducer(getIt.get<AuthService>());
  }

  static void dispose() {
    reducer?.dispose();
    signUpReducer?.dispose();
  }
}

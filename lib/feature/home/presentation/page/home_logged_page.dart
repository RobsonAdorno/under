import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under/feature/home/bussiness/bloc/home_logged_bloc.dart';

import '../../bussiness/state/home_logged_state.dart';

class HomeLogged extends StatelessWidget {
  const HomeLogged({
    super.key,
    required this.homeLoggeddBloc,
  });

  final HomeLoggeddBloc homeLoggeddBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<HomeLoggeddBloc, HomeLoggedState>(
          builder: (context, state) {
            return switch (state) {
              InitalHomeLoggedState _ => Container(),
              LoadingHomeLoggedState _ =>
                const Center(child: CircularProgressIndicator()),
              SucessHomeLoggedState sucessState => Center(
                  child: Text(sucessState.allProducts[0].toString()),
                ),
              ErrorHomeLoggedState errorState => Center(
                  child: Text(errorState.errorMessage),
                )
            };
          },
        ));
  }
}

import 'package:bloc/bloc.dart';
import 'package:under/feature/api/api.dart';
import 'package:under/feature/home/bussiness/event/event.dart';
import 'package:under/feature/home/bussiness/repository/i_home_logged_repository.dart';
import 'package:under/feature/home/bussiness/state/home_logged_state.dart';
import 'package:under/feature/home/data/exception/exception.dart';

class HomeLoggeddBloc extends Bloc<HomeLoggedEvent, HomeLoggedState> {
  HomeLoggeddBloc({
    required this.homeLoggedRepository,
  }) : super(InitalHomeLoggedState()) {
    on<AllProductsEvent>(_allProducts);
  }

  final IHomeLoggedRepository homeLoggedRepository;

  _allProducts(AllProductsEvent event, Emitter emit) async {
    emit(LoadingHomeLoggedState());

    Result resultAllProducts = await homeLoggedRepository.getAllProducts();

    if (resultAllProducts is Sucess) {
      emit(SucessHomeLoggedState(allProducts: resultAllProducts.value));
    }

    if (resultAllProducts is Failure) {
      emit(Failure(HomeLoggedException(
          message: resultAllProducts.exception.toString())));
    }
  }
}

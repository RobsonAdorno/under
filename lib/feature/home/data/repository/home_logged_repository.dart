import 'package:http/http.dart';
import 'package:under/feature/api/api.dart';
import 'package:under/feature/home/data/exception/exception.dart';

import '../../../api/http/http.dart';
import '../../bussiness/repository/i_home_logged_repository.dart';

class HomeLoggedRepository implements IHomeLoggedRepository {
  String uri = '/products';
  @override
  Future<Result<dynamic, HomeLoggedException>> getAllProducts() async {
    try {
      Response response = await Http(uri: uri).get();

      if (response.statusCode == 200) {
        return Sucess(response.body);
      }

      if (response.statusCode == 202) {
        return Sucess(response.body);
      }

      if (response.statusCode == 202) {
        return Sucess(response.body);
      }

      throw Failure(HomeLoggedException(message: response.body));
    } on FormatException catch (e) {
      throw Failure(
        Exception(e.message),
      );
    } on ClientException catch (e) {
      throw Failure(
        Exception(e.message),
      );
    }
  }
}

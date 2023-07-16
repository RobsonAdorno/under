import 'package:under/feature/home/bussiness/entity/product.dart';
import 'package:under/feature/home/bussiness/event/event.dart';
import 'package:under/feature/home/data/exception/exception.dart';

import '../../../api/result_request.dart';

abstract interface class IHomeLoggedRepository {
  Future<Result<dynamic, HomeLoggedException>> getAllProducts();
}

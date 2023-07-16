import '../../../api/result_request.dart';
import '../entity/sign_in.dart';

abstract interface class IAuthRepository {
  Future<Result<dynamic, Exception>> login(SignInEntity sign);
  void logout();
}

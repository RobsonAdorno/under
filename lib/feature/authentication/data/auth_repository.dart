import 'package:http/http.dart';
import 'package:under/feature/authentication/bussiness/entity/sign_in.dart';
import 'package:under/feature/authentication/bussiness/repository/i_auth_repository.dart';

import '../../api/http/http.dart';
import '../../api/result_request.dart';
import '../../api/strings.dart';

class AuthRepository implements IAuthRepository {
  final authString = '${StringsApi.baseUrl}/${StringsApi.login}';

  @override
  Future<Result<dynamic, Exception>> login(SignInEntity sign) async {
    try {
      Response response = await Http(uri: authString, body: {
        'username': sign.username,
        'password': sign.password,
      }).post();

      if (response.statusCode == 200) {
        return Sucess(response.body);
      }

      if (response.statusCode == 202) {
        return Sucess(response.body);
      }

      if (response.statusCode == 202) {
        return Sucess(response.body);
      }

      return Failure(Exception(response.body));
    } on FormatException catch (e) {
      return Failure(
        Exception(e.message),
      );
    } on ClientException catch (e) {
      return Failure(
        Exception(e.message),
      );
    }
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}

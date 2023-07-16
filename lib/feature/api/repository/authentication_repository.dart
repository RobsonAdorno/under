import 'package:http/http.dart';
import 'package:under/feature/api/api.dart';
import 'package:under/feature/entities/entities.dart';

import '../http/http.dart';
import '../strings.dart';
import '/feature/dto/dto.dart';

class AuthenticationRepository {
  final authString = '${StringsApi.baseUrl}/${StringsApi.login}';
  final registerUrl =
      '${StringsApi.baseUrl}/${StringsApi.uri}/${StringsApi.register}';
  Future<Result<String, Exception>> fetchLogin(SignInDTO auth) async {
    try {
      Response response = await Http(uri: authString, body: {
        'username': auth.username!,
        'password': auth.password!,
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

  Future<Result<String, Exception>> register(UserModel userModel) async {
    try {
      Response response = await Http(uri: registerUrl, body: {
        'user': {
          'cpf': userModel.cpf,
          'name': userModel.name,
          'lastName': userModel.lastName,
          'email': userModel.email,
          'password': userModel.password
        }
      }).post();

      if (response.statusCode == 200) {
        return Sucess(response.body);
      }

      return Failure(Exception(response.body));
    } on FormatException catch (e) {
      return Failure(Exception(e.message));
    } on ClientException catch (e) {
      return Failure(
        Exception(e.message),
      );
    }
  }
}

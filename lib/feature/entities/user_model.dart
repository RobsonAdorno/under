import 'dart:convert';

class UserModel {
  int? clientId;
  String? name;
  String? lastName;
  String? token;
  String? email;
  String? cpf;
  String? password;

  UserModel({
    this.clientId,
    this.name,
    this.lastName,
    this.token,
    this.email,
    this.cpf,
    this.password,
  });

  UserModel copyWith({
    int? clientId,
    String? name,
    String? lastName,
    String? token,
    String? email,
    String? cpf,
    String? password,
  }) {
    return UserModel(
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      token: token ?? this.token,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'name': name,
      'lastName': lastName,
      'token': token,
      'email': email,
      'cpf': cpf,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      clientId: map['clientId']?.toInt(),
      name: map['name'],
      lastName: map['lastName'],
      token: map['token'],
      email: map['email'],
      cpf: map['cpf'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(clientId: $clientId, name: $name, lastName: $lastName, token: $token, email: $email, cpf: $cpf, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.clientId == clientId &&
        other.name == name &&
        other.lastName == lastName &&
        other.token == token &&
        other.email == email &&
        other.cpf == cpf &&
        other.password == password;
  }

  @override
  int get hashCode {
    return clientId.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        token.hashCode ^
        email.hashCode ^
        cpf.hashCode ^
        password.hashCode;
  }
}

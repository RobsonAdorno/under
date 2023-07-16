import 'dart:convert';

class SignInDTO {
  String? username;
  String? password;

  SignInDTO({
    this.username,
    this.password,
  });

  SignInDTO copyWith({
    String? username,
    String? password,
  }) {
    return SignInDTO(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory SignInDTO.fromMap(Map<String, dynamic> map) {
    return SignInDTO(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInDTO.fromJson(String source) =>
      SignInDTO.fromMap(json.decode(source));

  @override
  String toString() => 'SignInDTO(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignInDTO &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}

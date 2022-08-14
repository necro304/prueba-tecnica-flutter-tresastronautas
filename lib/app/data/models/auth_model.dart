// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

AuthModel authFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.v,
  });

  String id;
  String name;
  String email;
  String password;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "__v": v,
  };
}

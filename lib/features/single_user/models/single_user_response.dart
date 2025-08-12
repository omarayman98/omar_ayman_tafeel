// To parse this JSON data, do
//
//     final singleUserResponse = singleUserResponseFromJson(jsonString);

import 'dart:convert';

SingleUserResponse singleUserResponseFromJson(String str) => SingleUserResponse.fromJson(json.decode(str));

String singleUserResponseToJson(SingleUserResponse data) => json.encode(data.toJson());

class SingleUserResponse {
  UserData data;
  Support support;

  SingleUserResponse({
    required this.data,
    required this.support,
  });

  factory SingleUserResponse.fromJson(Map<String, dynamic> json) => SingleUserResponse(
    data: UserData.fromJson(json["data"]),
    support: Support.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "support": support.toJson(),
  };
}

class UserData {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  UserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}

class SingleUserResponse {
  UserData data;
  Support support;

  SingleUserResponse({
    required this.data,
    required this.support,
  });

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

}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

}

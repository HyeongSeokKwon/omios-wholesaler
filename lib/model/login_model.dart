class LoginRequestModel {
  String id;
  String password;

  LoginRequestModel(
    this.id,
    this.password,
  );

  Map<String, String> toJson() {
    Map<String, String> map = {
      'username': id,
      'password': password,
    };
    return map;
  }
}

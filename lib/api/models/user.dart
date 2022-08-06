class User {
  String id = '', name = '', email = '', token = '';

  User({this.id = '', this.name = '', this.email = '', this.token = ''});

  User.fromJson(Map<String, dynamic> userJson, String userToken) {
    id = userJson["id"];
    name = userJson["name"];
    email = userJson["email"];
    token = userToken;
  }

  @override
  String toString() {
    return "Id : $id \nName : $name \nEmail : $email \nToken : $token";
  }
}

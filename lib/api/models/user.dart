class User {
  String id = '', pseudo = '', token = '';

  User();

  // User(this.id, this.pseudo, this.token);

  User.fromJson(Map<String, dynamic> userJson, String userToken) {
    id = userJson["id"];
    pseudo = userJson["pseudo"];
    token = userToken;
  }

  @override
  String toString() {
    return "Id : $id \nPseudo : $pseudo \nToken : $token";
  }
}

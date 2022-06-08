class Agence {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;

  Agence({this.id, this.name, this.image, this.email, this.token});

  // function to convert json data to user model
  factory Agence.fromJson(Map<String, dynamic> json) {
    return Agence(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image'],
        email: json['user']['email'],
        token: json['token']);
  }
}

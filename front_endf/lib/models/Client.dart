class Client {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;

  Client({this.id, this.name, this.image, this.email, this.token});

  // function to convert json data to user model
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        id: json['client']['id'],
        name: json['client']['name'],
        image: json['client']['image'],
        email: json['client']['email'],
        token: json['token']);
  }
}

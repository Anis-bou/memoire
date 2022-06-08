import 'package:blogapp/models/agence.dart';

class Comment {
  int? id;
  String? comment;
  String? name;

  Comment({this.id, this.comment, this.name});

  // map json to comment model
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      comment: json['comment'],
      name: json['name'],
    );
  }
}

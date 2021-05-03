import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String title;
  String description;
  String author;

  Post(DocumentSnapshot doc) {
    postId = doc.id;
    title = doc.data()["title"];
    description = doc.data()["description"];
    author = doc.data()["author"];
  }
}

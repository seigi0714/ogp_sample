import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId;
  String imageUrl;
  String userName;
  String profile;

  User(DocumentSnapshot doc) {
    userId = doc.id;
    imageUrl = doc.data()["imageUrl"];
    userName = doc.data()["name"];
    profile = doc.data()["profile"];
  }
}

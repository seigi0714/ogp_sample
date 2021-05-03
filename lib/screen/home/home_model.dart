import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ogp_sample/model/post.dart';
import 'package:ogp_sample/model/user.dart';

class HomeModel extends ChangeNotifier {
  List<User> users;
  List<Post> posts;

  bool isLoading = true;
  final firebase = FirebaseFirestore.instance;

  Future init() async {
    try {
      final userDocs = await firebase.collection('users').get();
      users = userDocs.docs.map((userDoc) => User(userDoc)).toList();
      final postDocs = await firebase.collection('posts').get();
      posts = postDocs.docs.map((postDocs) => Post(postDocs)).toList();
      endLoading();
    } catch (e) {
      print(e);
      endLoading();
    }
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:ogp_sample/model/post.dart';
import 'package:ogp_sample/model/user.dart';
import 'package:provider/provider.dart';

class PostModel extends ChangeNotifier {
  PostModel(this.context) : request = _getRequest(context) {
    init();
  }
  Post post;
  bool isLoading = true;
  final BuildContext context;
  final WebRequest request;
  final firebase = FirebaseFirestore.instance;

  Future init() async {
    try {
      final postId = request.data["postId"];
      post = await fetchPost(postId);
    } catch (e) {
      print(e);
    }
    endLoading();
  }

  Future<Post> fetchPost(String postId) async {
    final postDoc = await firebase.collection("posts").doc(postId).get();
    return Post(postDoc);
  }

  // WebRequestを返す
  static WebRequest _getRequest(BuildContext context) {
    return Provider.of<WebRequest>(context, listen: false);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:ogp_sample/model/user.dart';
import 'package:provider/provider.dart';

class UserModel extends ChangeNotifier {
  UserModel(this.context) : request = _getRequest(context) {
    init();
  }
  User user;
  bool isLoading = true;
  final BuildContext context;
  final WebRequest request;
  final firebase = FirebaseFirestore.instance;

  Future init() async {
    try {
      final userId = request.data["userId"];
      user = await fetchUser(userId);
    } catch (e) {
      print(e);
    }
    endLoading();
  }

  Future<User> fetchUser(String userId) async {
    final userDoc = await firebase.collection("users").doc(userId).get();
    return User(userDoc);
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

import 'package:flutter/material.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:ogp_sample/router/path_constants.dart';
import 'package:ogp_sample/screen/home/home_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
        create: (context) => HomeModel()..init(),
        builder: (context, child) {
          return Consumer<HomeModel>(builder: (context, model, child) {
            return Center(
                child: model.isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text("ユーザーリスト"),
                                SizedBox(
                                  height: 20,
                                ),
                                _userListWidget(model, context),
                                Text("投稿リスト"),
                                SizedBox(
                                  height: 20,
                                ),
                                _postListWidget(model, context),
                              ],
                            ),
                          ],
                        ),
                      ));
          });
        });
  }

  Widget _userListWidget(HomeModel model, BuildContext context) {
    final userList = model.users.map((user) {
      return GestureDetector(
        child: Container(
          width: 240,
          child: Card(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Container(
                        width: 72,
                        height: 72,
                        child: Image.network(
                          user.imageUrl,
                        ),
                      ),
                    ),
                  ),
                  Text(user.userName),
                  Text(user.profile),
                ],
              ),
            ),
          ),
        ),
        onTap: () async {
          final request = WebRequest.request(
            PathConstants.routeUser,
            data: {"userId": user.userId},
          );
          await Navigator.of(context).pushReplacementNamed(
            request.uri.toString(),
          );
        },
      );
    }).toList();

    return Wrap(
      children: userList,
    );
  }

  Widget _postListWidget(HomeModel model, BuildContext context) {
    final postList = model.posts.map((post) {
      return GestureDetector(
        child: Container(
          width: 240,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    post.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(post.description)
                ],
              ),
            ),
          ),
        ),
        onTap: () async {
          final request = WebRequest.request(
            PathConstants.routePost,
            data: {"postId": post.postId},
          );
          await Navigator.of(context).pushReplacementNamed(
            request.uri.toString(),
          );
        },
      );
    }).toList();

    return Wrap(
      children: postList,
    );
  }
}

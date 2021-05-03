import 'package:flutter/material.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:ogp_sample/router/path_constants.dart';
import 'package:ogp_sample/screen/post/post_model.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostModel>(
        create: (context) => PostModel(context),
        builder: (context, child) {
          return Consumer<PostModel>(builder: (context, model, child) {
            return Center(
                child: model.isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Text("ユーザーページ"),
                          SizedBox(height: 20),
                          _userWidget(model),
                        ],
                      ));
          });
        });
  }

  Widget _userWidget(PostModel model) {
    return Container(
      width: 240,
      child: Card(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  model.post.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 20),
                Text(model.post.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

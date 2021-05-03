import 'package:flutter/material.dart';
import 'package:ogp_sample/screen/user/user_model.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>(
        create: (context) => UserModel(context),
        builder: (context, child) {
          return Consumer<UserModel>(builder: (context, model, child) {
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

  Widget _userWidget(UserModel model) {
    return Container(
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
                      model.user.imageUrl,
                    ),
                  ),
                ),
              ),
              Text(model.user.userName),
              Text(model.user.profile),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:store_app/helper/api.dart';
import '../models/user_model.dart';

class GetUserData {
  Future<UserModel?> getUserData({
    required String userName,
  }) async {
    List<dynamic> data = await Api().get(url: 'https://fakestoreapi.com/users');
    List<UserModel> users =
        data.map((json) => UserModel.fromJSON(json)).toList();

    UserModel? user;

    for (var element in users) {
      if (element.username == userName) {
        user = element;
      }
    }

    return user;
  }
}

import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_result_model.dart';

abstract class LoginUserDatasource {
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password);
}

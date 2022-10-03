import '../models/user_create_account_model.dart';

abstract class CreateAccountDatasource {
  Future<String> createAccountWithEmailAndPassword(UserCreateAccountModel user);
}

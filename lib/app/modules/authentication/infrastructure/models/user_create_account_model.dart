import '../../domain/entities/user_create_account.dart';

class UserCreateAccountModel extends UserCreateAccount {
  UserCreateAccountModel(super.name, super.email, super.password, super.photo);

  factory UserCreateAccountModel.fromUser(UserCreateAccount user) =>
      UserCreateAccountModel(user.name, user.email, user.password, user.photo);

  Map<String, dynamic> toMap() =>
      {'name': super.name, 'email': super.email, 'photo': super.photo};
}

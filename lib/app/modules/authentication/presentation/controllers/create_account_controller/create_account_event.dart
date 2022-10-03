abstract class CreateAccountEvent {
  const CreateAccountEvent();
}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final String email;
  final String password;
  final String passwordConfirme;
  final String name;
  final String? photo;

  CreateAccountWithEmailAndPasswordEvent(
      {required this.email,
      required this.password,
      required this.passwordConfirme,
      required this.name,
      this.photo});
}

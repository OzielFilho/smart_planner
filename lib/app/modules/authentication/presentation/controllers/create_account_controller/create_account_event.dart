import 'dart:io';

abstract class CreateAccountEvent {
  const CreateAccountEvent();
}

class CreateAccountWithEmailAndPasswordEvent implements CreateAccountEvent {
  final String email;
  final String password;
  final String passwordConfirme;
  final String name;
  final String? photo;
  File? fileImage;

  CreateAccountWithEmailAndPasswordEvent(
      {required this.email,
      required this.password,
      required this.passwordConfirme,
      required this.name,
      required this.fileImage,
      this.photo});
}

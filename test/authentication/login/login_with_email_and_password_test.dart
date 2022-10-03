import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_result.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/login_user_repository.dart';
import 'package:smart_planner/app/modules/authentication/domain/usecases/login/login_with_email_and_password.dart';

class LoginRepositoryImpl extends Mock implements LoginUserRepository {}

void main() {
  LoginWithEmailAndPassword? usecase;
  LoginUserRepository? repositoryMock;

  setUp(() {
    repositoryMock = LoginRepositoryImpl();
    usecase = LoginWithEmailAndPassword(repositoryMock!);
  });

  group('Login Group', () {
    final resultAuth = UserResult('Oziel', 'oziel@hotmail.com');
    test('Should do login of user if params is not empty', () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(
          const Params(email: 'jose@hotmail.com', password: '123456'));

      expect(result, right(resultAuth));
      verify(() => repositoryMock!
          .loginWithEmailAndPassword('jose@hotmail.com', '123456'));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsEmptyLoginFailure if email or password is empty',
        () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsEmptyLoginFailure()));

      final result = await usecase!(const Params(email: '', password: ''));

      expect(result, left(ParamsEmptyLoginFailure()));
    });

    test('Should returns ParamsInvalidLoginFailure if email is not valid',
        () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsInvalidLoginFailure()));

      final result =
          await usecase!(const Params(email: 'kkk.com', password: '1234567'));

      expect(result, left(ParamsInvalidLoginFailure()));
    });

    test('Should returns ParamsInvalidLoginFailure if password is less than 6',
        () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsInvalidLoginFailure()));

      final result = await usecase!(
          const Params(email: 'jose@hotmail.com', password: '1234'));

      expect(result, left(ParamsInvalidLoginFailure()));
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_create_account.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/create_account_repository.dart';
import 'package:smart_planner/app/modules/authentication/domain/usecases/create_account/create_account_with_email_and_password.dart';

class CreateAccountRepositoryImpl extends Mock
    implements CreateAccountRepository {}

void main() {
  CreateAccountWithEmailAndPassword? usecase;
  CreateAccountRepository? repositoryMock;
  final userCreate =
      UserCreateAccount('oziel', 'jose@hotmail.com', '123456', '');
  setUp(() {
    repositoryMock = CreateAccountRepositoryImpl();
    usecase = CreateAccountWithEmailAndPassword(repositoryMock!);
  });

  setUpAll(() {
    registerFallbackValue(userCreate);
  });

  group('Create Account Group', () {
    test('Should do login of user if params is not empty and not invalid',
        () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => right(''));

      final result = await usecase!(userCreate);

      expect(result, right(''));
      verify(
          () => repositoryMock!.createAccountWithEmailAndPassword(userCreate));
      verifyNoMoreInteractions(repositoryMock);
    });

    test(
        'Should returns ParamsEmptyCreateAccountFailure if email or password or name is empty',
        () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => left(ParamsEmptyCreateAccountFailure()));

      final result = await usecase!(UserCreateAccount('', '', '', ''));

      expect(result, left(ParamsEmptyCreateAccountFailure()));
    });

    test(
        'Should returns ParamsInvalidCreateAccountFailure if email or password is invalid',
        () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => left(ParamsInvalidCreateAccountFailure()));

      final result =
          await usecase!(UserCreateAccount('ozile', 'ozie.com', '1234', ''));

      expect(result, left(ParamsInvalidCreateAccountFailure()));
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/recovery_password_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_planner/app/modules/authentication/domain/usecases/recovery_password/recovery_with_email.dart';

class RecoveryPasswordRepositoryImpl extends Mock
    implements RecoveryPasswordRepository {}

void main() {
  RecoveryWithEmail? usecase;
  RecoveryPasswordRepository? repositoryMock;

  setUp(() {
    repositoryMock = RecoveryPasswordRepositoryImpl();
    usecase = RecoveryWithEmail(repositoryMock!);
  });

  group('Recovery Password Group', () {
    test('Should do recovery of password if email is not empty', () async {
      when(() => repositoryMock!.recoveryWithEmail(any()))
          .thenAnswer((_) async => right('Sucesso'));
      final result = await usecase!('jose@hotmail.com');
      expect(result, right('Sucesso'));
      verify(() => repositoryMock!.recoveryWithEmail('jose@hotmail.com'));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsEmptyRecoveryPasswordFailure if email is empty',
        () async {
      when(() => repositoryMock!.recoveryWithEmail(any()))
          .thenAnswer((_) async => left(ParamsEmptyRecoveryPasswordFailure()));

      final result = await usecase!('');

      expect(result, left(ParamsEmptyRecoveryPasswordFailure()));
    });

    test(
        'Should returns ParamsInvalidRecoveryPasswordFailure if email is not valid',
        () async {
      when(() => repositoryMock!.recoveryWithEmail(any())).thenAnswer(
          (_) async => left(ParamsInvalidRecoveryPasswordFailure()));

      final result = await usecase!('ieuisl@.co');

      expect(result, left(ParamsInvalidRecoveryPasswordFailure()));
    });
  });
}

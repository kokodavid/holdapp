import 'package:dartz/dartz.dart';
import 'package:hold_app/domain/usecases/auth/sign_in_with_google.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../repositories/auth/auth_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  final AuthRepository repository;
  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}

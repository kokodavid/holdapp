import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../entities/auth/user_entitity.dart';
import '../../repositories/auth/auth_repository.dart';


class SignInWithGoogle implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}

class NoParams {}


import 'package:dartz/dartz.dart';
import 'package:hold_app/domain/usecases/auth/sign_in_with_google.dart';
import '../../../../core/error/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../entities/auth/user_entitity.dart';
import '../../repositories/auth/auth_repository.dart';

class GetCurrentUser implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;
  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}

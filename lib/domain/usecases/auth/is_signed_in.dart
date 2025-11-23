import 'package:dartz/dartz.dart';
import 'package:hold_app/domain/usecases/auth/sign_in_with_google.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../repositories/auth/auth_repository.dart';

class IsSignedIn implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  IsSignedIn(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isSignedIn();
  }
}

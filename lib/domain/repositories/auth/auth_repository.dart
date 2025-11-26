import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../entities/auth/user_entitity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  // placeholder for future email-link flows

}

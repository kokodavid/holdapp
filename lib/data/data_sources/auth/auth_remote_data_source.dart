import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exceptions.dart';
import '../../models/auth/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final fb.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> signInWithGoogle() async {
    print(' [AuthRemoteDataSource] Starting Google sign in process...');
    try {
      print(' [AuthRemoteDataSource] Initiating Google sign in UI...');
      final googleUser = await googleSignIn.signIn();
      print(' [AuthRemoteDataSource] Google user result: $googleUser');

      if (googleUser == null) {
        print(' [AuthRemoteDataSource] User cancelled Google sign in');
        throw ServerException('User cancelled Google sign in');
      }

      print(' [AuthRemoteDataSource] Getting Google authentication...');
      final googleAuth = await googleUser.authentication;
      print('[AuthRemoteDataSource] Google auth received - accessToken: ${googleAuth.accessToken != null ? "present" : "missing"}, idToken: ${googleAuth.idToken != null ? "present" : "missing"}');

      final credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print(' [AuthRemoteDataSource] Signing in with Firebase credential...');
      final userCredential = await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      print(' [AuthRemoteDataSource] Firebase user: $user');

      if (user == null) {
        print(' [AuthRemoteDataSource] No user returned from Firebase after sign in');
        throw ServerException('No user returned from Firebase');
      }

      print(' [AuthRemoteDataSource] Google sign in successful! User: ${user.uid}, Email: ${user.email}');
      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      print(' [AuthRemoteDataSource] Google sign in failed with error: $e');
      print(' [AuthRemoteDataSource] Error type: ${e.runtimeType}');
      print(' [AuthRemoteDataSource] Converting to ServerException...');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    print(' [AuthRemoteDataSource] Starting sign out process...');
    try {
      print(' [AuthRemoteDataSource] Signing out from Google...');
      await googleSignIn.signOut();
      print(' [AuthRemoteDataSource] Google sign out successful');

      print('[AuthRemoteDataSource] Signing out from Firebase...');
      await firebaseAuth.signOut();
      print(' [AuthRemoteDataSource] Firebase sign out successful');

      print(' [AuthRemoteDataSource] Complete sign out successful');
    } catch (e) {
      print(' [AuthRemoteDataSource] Sign out failed with error: $e');
      print('[AuthRemoteDataSource] Error type: ${e.runtimeType}');
      print(' [AuthRemoteDataSource] Converting to ServerException...');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = firebaseAuth.currentUser;
    final isSignedIn = currentUser != null;

    print(' [AuthRemoteDataSource] Checking if user is signed in...');
    print(' [AuthRemoteDataSource] Current Firebase user: $currentUser');
    print('[AuthRemoteDataSource] isSignedIn result: $isSignedIn');

    if (isSignedIn) {
      print(' [AuthRemoteDataSource] User is signed in - UID: ${currentUser!.uid}');
    } else {
      print(' [AuthRemoteDataSource] No user signed in');
    }

    return isSignedIn;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    print(' [AuthRemoteDataSource] Getting current user...');
    final u = firebaseAuth.currentUser;
    print(' [AuthRemoteDataSource] Raw Firebase user: $u');

    if (u == null) {
      print(' [AuthRemoteDataSource] No current user found');
      return null;
    }

    print(' [AuthRemoteDataSource] Current user found - UID: ${u.uid}, Email: ${u.email}');
    final userModel = UserModel.fromFirebaseUser(u);
    print(' [AuthRemoteDataSource] Converted to UserModel: ${userModel.toJson()}');

    return userModel;
  }
}
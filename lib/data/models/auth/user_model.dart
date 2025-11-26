import '../../../domain/entities/auth/user_entitity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uid,
    String? email,
    String? firstName,
    String? lastName,
    String? displayName,
    String? photoUrl,
    bool isEmailVerified = false,
  }) : super(
    uid: uid,
    email: email,
    firstName: firstName,
    lastName: lastName,
    displayName: displayName,
    photoUrl: photoUrl,
    isEmailVerified: isEmailVerified,
  );

  factory UserModel.fromFirebaseUser(dynamic user) {
    // firebase_auth.User
    return UserModel(
      uid: user.uid,
      email: user.email,
      firstName: user.displayName,
      lastName: user.displayName,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
    'firstName': firstName,
    'lastName': lastName,
    'photoUrl': photoUrl,
    'isEmailVerified': isEmailVerified,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
    );
  }
}


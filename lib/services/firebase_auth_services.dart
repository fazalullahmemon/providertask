import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class MyUser {
  const MyUser({required this.uid});
  final String uid;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(User user) {
    return user;
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((user) => user!);
  }

  Future<User> signInAnonymously() async {
    print('inside signInAnonymously()');
    final authResult = await _firebaseAuth.signInAnonymously();
    // return _userFromFirebase(authResult.user);
    print('authResult: $authResult');
    return authResult.user!;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password, String username) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return firebaseAuth.currentUser.updateDisplayName(username);
  }

  Future<void> signOut() async {
    return Future.wait([firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    return await firebaseAuth.currentUser;
  }
}

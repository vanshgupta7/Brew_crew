import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first/models/user.dart';
import 'package:firebase_first/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userfromFirebase(User user) {
    return Users(user.uid);
  }

  Stream<Users?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebase(user!));
  }

  //sign in anonymously
  Future signinAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with E-mail and password
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with E-mail and password
  Future registerInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(user!.uid).updateUserData('0', 'new member', 100);
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

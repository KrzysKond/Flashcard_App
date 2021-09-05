import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();
   //sign in
  Future<String?> signIn({required String email, required String password}) async{
    try{
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  //sing up
  Future<String?> signUp({required String email, required String password}) async{
    try{
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'Signed up';

    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  //sign out
  Future<String?> signOut() async{
    try{
      await _firebaseAuth
          .signOut();
      return 'logged out';
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

}
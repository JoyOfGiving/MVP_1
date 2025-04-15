import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Email Sign Up
  Future<User?> signUpWithEmail(String email, String password, String name, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await _db.collection('users').doc(user!.uid).set({
        'name': name,
        'email': email,
        'role': role,  // "donor" / "volunteer" / "ngo"
        'createdAt': FieldValue.serverTimestamp(),
      });

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Email Login
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
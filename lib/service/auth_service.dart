import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fStore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

Future<UserCredential> signUpWithEmailPassword(
    String email, password, name) async {
  try {
    // Create user with email and password
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update display name
    await userCredential.user!.updateDisplayName(name);

    // Reload user data to ensure the updated display name is available
    await userCredential.user!.reload();

    // Set user data in Firestore
    await fStore.collection('Users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
      'name': name,
    });

    // Return user credential
    return userCredential;
  } on FirebaseAuthException catch (e) {
    throw Exception(e.code);
  }
}


  Future<void> signOut() async {
    return await auth.signOut();
  }
}

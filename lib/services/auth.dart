// lib/services/auth.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future<String?> registerWithEmailPassword(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      // Ensure passwords match
      if (password != confirmPassword) {
        return 'Passwords do not match';
      }

      // Create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
      }

      return null; // Registration successful, no errors
    } on FirebaseAuthException catch (e) {
      // Catch Firebase-specific errors and return corresponding messages
      if (e.code == 'email-already-in-use') {
        return 'The email is already in use. Please use a different email.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak. Please choose a stronger password.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is invalid. Please enter a valid email.';
      } else {
        return e.message; // Return any other FirebaseAuthException message
      }
    } catch (e) {
      return 'An error occurred. Please try again later.';
    }
  }
}

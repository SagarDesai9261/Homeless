import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Firestore_service.dart';
import 'model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestoreService = FirestoreService();

  Future<UserApp?> registerUser(UserApp user) async {
    try {
      // Register the user with Firebase Authentication first (you can use email/password or Google sign-in)
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      final User? firebaseUser = authResult.user;

      // If Firebase Authentication succeeds, store user data in Firestore
      if (firebaseUser != null) {
        user = user.copyWith(
            uid: firebaseUser.uid); // Set the UID in the UserApp object
        await _firestoreService.createUserRecord(user);
        return user;
      }
      return null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Fetch additional user data from Google account
          final String? displayName = user.displayName;
          final String? email = user.email;

          // Create a UserApp object
          final UserApp userData = UserApp(
            uid: user.uid,
            email: email,
            fullName: displayName,
            // Add other fields as needed
          );

          // Store the user data in Firestore
          await _firestoreService.createUserRecord(userData);

          return userData;
        }
      }
      return null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = authResult.user;

      if (firebaseUser != null) {
        final user = await _firestoreService.getUserData(firebaseUser.uid);
        return "";
      }
      return "";
    } catch (error) {
      print(error.toString());
      return "Email and Password is invalid";
    }
  }
  // ... Other authentication methods and sign-in options

  Future<UserApp?> getUserData(String uid) async {
    return _firestoreService.getUserData(uid);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }
}

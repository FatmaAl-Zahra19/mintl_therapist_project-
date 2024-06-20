import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        assert(!user!.isAnonymous);
        assert(await user!.getIdToken() != null);

        final User? currentUser = _auth.currentUser;
        assert(user!.uid == currentUser!.uid);

        return user;
      }
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  // Check if user data is complete
  Future<bool> isDataComplete() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Query Firestore to check if the user's email exists in the collection
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('user_info')
            .where('Email', isEqualTo: user.email)
            .get();

        // If the query returns any documents, it means the user's email exists in the collection
        if (querySnapshot.docs.isNotEmpty) {
          return true; // User's data is complete
        } else {
          return false; // User's data is incomplete
        }
      }
      return false;
    } catch (error) {
      print("Error checking user data: $error");
      return false;
    }
  }


  // Sign out
  Future<void> signOut() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await googleSignIn.signOut();
        await user.delete(); // Delete user from Authentication
      }
      await _auth.signOut();
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
}

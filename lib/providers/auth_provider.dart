import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// **AuthService** class handles Firebase Authentication
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Stream for authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// **Sign in with Google**
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  /// **Sign out**
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}

/// **Riverpod Provider for Authentication**
final authProvider = Provider<AuthService>((ref) => AuthService());

/// **Riverpod State Provider for Auth Changes**
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authProvider);
  return authService.authStateChanges;
});

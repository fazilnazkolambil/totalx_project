import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoading;
  final String? verificationId;
  final User? user;

  AuthState({this.isLoading = false, this.verificationId, this.user});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    state = AuthState(isLoading: true);

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        state = AuthState(isLoading: false);
      },
      codeSent: (String verificationId, int? resendToken) {
        state = AuthState(isLoading: false, verificationId: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        state = AuthState(isLoading: false, verificationId: verificationId);
      },
    );
  }

  Future<void> signInWithSmsCode(String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: state.verificationId!,
      smsCode: smsCode,
    );
    await _signInWithCredential(credential);
  }

  Future<void> _signInWithCredential(AuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      state = AuthState(user: userCredential.user);
    } catch (e) {
      state = AuthState();
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
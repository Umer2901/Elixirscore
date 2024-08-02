import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/signin.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// ignore_for_file: use_build_context_synchronously

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  String? _verificationId;
  String? _phoneNumber;

  User? get user => _user;

  Future<void> registerWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
      Get.toNamed(AppRoutes.phoneAuth);
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    }
  }

  Future<void> loginWithEmailAndPassword(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _user = userCredential.user;

    if (_user != null) {
      final phoneNumber = _user!.phoneNumber;

      if (phoneNumber == null) {
        Get.toNamed(AppRoutes.phoneAuth);
      } else {
        await verifyPhoneNumber(context, phoneNumber);
      }
    }

    notifyListeners();
  } on FirebaseAuthException catch (e) {
    _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
  }
}

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to sign out');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.to(const Signin());
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    } catch (e) {
      _showErrorSnackbar(context, 'An unknown error occurred');
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    } catch (e) {
      _showErrorSnackbar(context, 'An unknown error occurred');
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    }
  }

 Future<void> verifyPhoneNumber(BuildContext context, String phoneNumber) async {
  try {
    _phoneNumber = phoneNumber; 
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        User? currentUser = _auth.currentUser;

        if (currentUser != null) {
          await currentUser.updatePhoneNumber(credential);
          await currentUser.reload();
          _user = _auth.currentUser;
        } else {
          await _auth.signInWithCredential(credential);
          _user = _auth.currentUser;
        }

        notifyListeners();
        Get.toNamed(AppRoutes.basicinfo);
      },
      verificationFailed: (FirebaseAuthException e) {
        _showErrorSnackbar(context, e.message ?? 'Phone number verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        Get.toNamed(AppRoutes.otp, arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  } catch (e) {
    _showErrorSnackbar(context, 'Phone number verification failed');
  }
}

Future<void> verifyOtp(BuildContext context, String verificationId, String otp) async {
  try {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      await currentUser.updatePhoneNumber(credential);
      await currentUser.reload();
      _user = _auth.currentUser;
    } else {
      await _auth.signInWithCredential(credential);
      _user = _auth.currentUser;
    }

    notifyListeners();
    Get.toNamed(AppRoutes.basicinfo);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'credential-already-in-use') {
      _showErrorSnackbar(context, 'This phone number is already in use');
    } else {
      _showErrorSnackbar(context, 'OTP verification failed: ${e.message}');
    }
  } catch (e) {
    _showErrorSnackbar(context, 'An unknown error occurred');
  }
}



  Future<void> resendOtp(BuildContext context) async {
    if (_phoneNumber == null || _verificationId == null) {
      _showErrorSnackbar(context, 'Cannot resend OTP. Phone number or verification ID is missing.');
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber!,
        verificationCompleted: (PhoneAuthCredential credential) async {
          User? currentUser = _auth.currentUser;

          if (currentUser != null) {
            await currentUser.updatePhoneNumber(credential);
            await currentUser.reload();
            _user = _auth.currentUser;
          } else {
            await _auth.signInWithCredential(credential);
            _user = _auth.currentUser;
          }

          notifyListeners();
          Get.toNamed(AppRoutes.basicinfo);
        },
        verificationFailed: (FirebaseAuthException e) {
          _showErrorSnackbar(context, e.message ?? 'Phone number verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          Get.toNamed(AppRoutes.otp, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to resend OTP');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

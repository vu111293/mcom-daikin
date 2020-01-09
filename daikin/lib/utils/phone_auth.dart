import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class PhoneAuthUtils {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static StreamController _authStream =
      StreamController<FirebaseAuthResult>.broadcast();

  static final PhoneAuthUtils _instance = new PhoneAuthUtils._internal();
  static String _verificationId;

  factory PhoneAuthUtils() {
    return _instance;
  }

  PhoneAuthUtils._internal();

  dispose() {
    _authStream.close();
  }

  Stream<FirebaseAuthResult> get authStream => _authStream.stream;

//  PhoneVerificationCompleted verificationCompleted = (FirebaseUser user) async {
//    final String token = await user.getIdToken();
////    _authStream.add(AuthResult(status: AuthStatus.Verified, token: token));
////    var auth = new LoopBackAuth();
////    auth.setAccessToken(_token, false);
////    loginWithToken(_token);
//  };

  PhoneVerificationCompleted verificationCompleted =
      (AuthCredential phoneAuthCredential) async {
    AuthResult authResult =
        await _auth.signInWithCredential(phoneAuthCredential);
    _authStream.add(FirebaseAuthResult(
        status: AuthStatus.Verified,
        token: (await authResult.user.getIdToken()).token,
        user: authResult.user));
  };

  PhoneVerificationFailed verificationFailed = (AuthException authException) {
    if (authException.code == 'quotaExceeded') {
      _authStream.add(FirebaseAuthResult(
          status: AuthStatus.QuotaExceeded, msg: authException.message));
    } else {
      _authStream.add(FirebaseAuthResult(
          status: AuthStatus.Fail, msg: authException.message));
    }
  };

  PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    _verificationId = verificationId;
    _authStream.add(FirebaseAuthResult(status: AuthStatus.CodeSent));
  };

  PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    _authStream.add(FirebaseAuthResult(status: AuthStatus.Timeout));
    _verificationId = verificationId;
  };

  verifyPhoneNumber(String phone) async {
    print("verifyPhoneNumber");
    if (phone.startsWith('0')) phone = phone.substring(1);
    await _auth.verifyPhoneNumber(
        phoneNumber: '+84' + phone,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: 1);
  }

  validateCode(String code) async {
    print("validateCode");
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: code,
    );
    print(credential);
    AuthResult authRes = await _auth
        .signInWithCredential(credential)
        .catchError((e) {
      print(e.toString());
      _authStream
          .add(FirebaseAuthResult(status: AuthStatus.Fail, msg: e.toString()));
    });

    final String token = (await authRes.user.getIdToken()).token;
    print('Token: $token');
    print(authRes.user.uid);
    _authStream.add(FirebaseAuthResult(
        status: AuthStatus.Verified, token: token, user: authRes.user));
  }

  loginWithEmailVsPassword(String email, String password) async {
    AuthResult res = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      _authStream
          .add(FirebaseAuthResult(status: AuthStatus.Fail, msg: e.toString()));
      return;
    });
    if (res != null) {
      String token = (await res.user.getIdToken()).token;
      _authStream.add(FirebaseAuthResult(
          status: AuthStatus.Verified, token: token, user: res.user));
    }
  }
}

enum AuthStatus { Verified, Timeout, CodeSent, Fail, QuotaExceeded }

class FirebaseAuthResult {
  AuthStatus status;
  String token;
  String msg;
  FirebaseUser user;

  FirebaseAuthResult({this.status, this.token, this.msg, this.user});
}

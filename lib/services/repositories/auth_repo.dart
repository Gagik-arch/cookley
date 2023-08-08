import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

class _AuthRepository {
  final _FA = FirebaseAuth.instance;

  Future sendMobileNumber({
    mobileNumber,
    void Function({String verificationId, int? resendToken})? onSuccess,
    void Function(FirebaseAuthException e)? onError,
  }) async {
    try {
      await _FA.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('verificationCompleted111111111111== $credential');
        },
        verificationFailed: (FirebaseAuthException e) {
          if (onError != null) {
            onError(e);
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          onSuccess!(verificationId: verificationId, resendToken: resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      if (onError != null) {
        if (kDebugMode) {
          print('Verification failed!');
        }
      }
    }
  }

  Future verifyMobileNumber({
    required String verificationId,
    required String smsCode,
  }) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _FA.signInWithCredential(credential);
  }
}

final authRepository = _AuthRepository();

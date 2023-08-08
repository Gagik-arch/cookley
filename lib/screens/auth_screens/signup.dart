import 'package:flutter/material.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/resources/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cookley/screens/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/repositories/auth_repo.dart' show authRepository;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _mobileNumber = '';

  void submit() {
    if (_mobileNumber != '') {
      authRepository
          .sendMobileNumber(
        mobileNumber: _mobileNumber,
        onError: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Invalid phone number!'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Verification failed!'),
            ));
          }
        },
        onSuccess: ({String? verificationId, int? resendToken}) {
          if (verificationId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(
                      verificationId: verificationId,
                      mobileNumber: _mobileNumber,
                      isSignin: true)),
            );
          }
        },
      )
          .then((value) {
        print(value);
      }).catchError((e) {
        print(e);
      });
    }
  }

  void _onFinish({String? value, String? name, bool? isValid}) {
    if (name != null && value != null) {
      setState(() {
        _mobileNumber = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/login-frame.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('SignupScreen.title'.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        'lestGetYouStarted'.tr(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.lightGray,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Input(
                        keyboardType: TextInputType.phone,
                        label: 'mobileNumber'.tr(),
                        name: 'mobileNumber',
                        onFinish: _onFinish,
                        validationKey: 'phone',
                      ),
                      const Spacer(),
                      Button(
                        onPress: submit,
                        disabled: _mobileNumber == '',
                        variant: Variant.primary,
                        label: 'signup'.tr(),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

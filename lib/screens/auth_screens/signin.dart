import 'package:cookley/services/repositories/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/resources/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../controllers/main.dart';
import '../../services/repositories/auth_repo.dart';
import '../../services/repositories/user_repo.dart' show userRepository;
import 'OTP.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String? _mobileNumber;

  void submit() async {
    if (_mobileNumber != null) {
      authRepository
          .sendMobileNumber(
        mobileNumber: _mobileNumber,
        onError: (FirebaseAuthException e) {
          print(e);
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sending Message"),
      ));
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
    UserController model = context.watch<UserController>();
    print(model.count);
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
                      Text('SigninScreen.title'.tr(),
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
                        keyboardType: TextInputType.number,
                        label: 'mobileNumber'.tr(),
                        onFinish: _onFinish,
                        validationKey: 'phone',
                        name: 'mobileNumber',
                      ),
                      const Spacer(),
                      Button(
                        onPress: submit,
                        variant: Variant.primary,
                        label: 'signin'.tr(),
                        disabled: _mobileNumber == '',
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

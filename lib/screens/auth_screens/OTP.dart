import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/resources/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cookley/screens/main.dart';
import 'dart:async';
import '../../navigation/tab_navigation.dart';
import '../../services/repositories/auth_repo.dart' show authRepository;

class OTPScreen extends StatefulWidget {
  OTPScreen({
    required this.verificationId,
    required this.mobileNumber,
    this.isSignin = false,
    super.key,
  });
  String verificationId;
  String? mobileNumber;
  bool isSignin;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isSucced = false;
  String smsCode = '';
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _onSubmit() {
      setState(() => isSucced = true);
      authRepository
          .verifyMobileNumber(
              verificationId: widget.verificationId, smsCode: smsCode)
          .then((res) {
        if (widget.isSignin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TabNavigation()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileInfoScreen(mobileNumber: widget.mobileNumber)),
          );
        }
      }).catchError((e) {
        if (e.code == 'invalid-verification-code') {
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: const Text('Invalid verification code! Try Again.'),
              action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    scaffold.hideCurrentSnackBar();
                    setState(() {
                      isSucced = false;
                    });
                  }),
            ),
          );
        }
      }).then((value) {
        setState(() {
          isSucced = false;
        });
      });
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: isSucced
            ? null
            : AppBar(iconTheme: const IconThemeData(color: Colors.black)),
        body: Container(
          decoration: isSucced
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (isSucced)
                  renderSuccedMessage()
                else ...[
                  Text('OTPScreen.title'.tr(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                    'OTPScreen.subtitle'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.lightGray,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Input(
                    onFinish: ({String? name, String? value, bool? isValid}) {
                      if (value != null) {
                        setState(() {
                          smsCode = value;
                        });
                      }
                    },
                    validationKey: 'otp',
                    keyboardType: TextInputType.number,
                    label: 'enterCode'.tr(),
                  ),
                  const SizedBox(height: 36),
                  Button(
                    onPress: () {
                      _onSubmit();
                    },
                    variant: Variant.primary,
                    label: 'confirm'.tr(),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'OTPScreen.didNotReceive'.tr(),
                        style: TextStyle(color: AppColor.lightGray),
                      ),
                      const SizedBox(width: 6),
                      Button(
                        onPress: () {},
                        child: Text(
                          'resend'.tr(),
                          style: TextStyle(color: AppColor.green),
                        ),
                      ),
                    ],
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget renderSuccedMessage() {
  return Column(
    children: [
      Image.asset('assets/images/logo.png'),
      const SizedBox(height: 60),
      Text(
        'OTPScreen.pleaseTellUs'.tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
      )
    ],
  );
}

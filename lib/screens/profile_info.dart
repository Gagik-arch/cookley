import 'dart:io';
import 'package:cookley/services/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:cookley/core/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cookley/resources/main.dart';

import '../models/main.dart';
import '../services/repositories/global.dart';
import 'auth_screens/signin.dart';

class ProfileInfoScreen extends StatefulWidget {
  ProfileInfoScreen({mobileNumber, super.key});

  String? mobileNumber = '+37498116141';

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

const List<String> _genders = <String>['Male', 'Female'];

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  Map<String, dynamic> body = {};
  List<TypeOfCusines> typeCusines = [];
  List<FoodTypeModel> foodTypes = [];
  FoodTypeModel? selectedFoodType;
  TypeOfCusines? selectedTypeCusine;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalRepository.getFoodTypesAndTypeOfCusiness().then((res) {
        List<TypeOfCusines> _typeCusines = [];
        List<FoodTypeModel> _foodTypes = [];

        for (int i = 0; i < res[0].docs.length; i++) {
          _foodTypes.add(FoodTypeModel.fromMap(res[0].docs[i].data()));
        }
        for (int i = 0; i < res[1].docs.length; i++) {
          _typeCusines.add(TypeOfCusines.fromMap(res[1].docs[i].data()));
        }
        setState(() {
          typeCusines = _typeCusines;
          foodTypes = _foodTypes;
        });
      }).catchError((e) {
        print(e);
      });
    });
    super.initState();
  }

  void onChangeFields({String? value, String? name, bool? isValid}) {
    if (value != null && name != null) {
      setState(() {
        body = onChangeBody(value, name, body, isValid);
      });
    }
  }

  void onSubmit() async {
    try {
      Locale? locale = await getLanguage();
      if (locale != null) {
        UserSettingsModel settings = UserSettingsModel(
            language: locale.toString(), pushNotification: false);

        UserModel newUser = UserModel.fromMap({
          ...body,
          'mobileNumber': widget.mobileNumber,
          'settings': settings
        });
        userRepository.createUser(newUser).then((res) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SigninScreen()),
          );
        }).catchError((e) {
          print(e);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // void onPressTypeOfCuisine() {
    //   showModalBottomSheet<void>(
    //     isScrollControlled: true,
    //     useSafeArea: true,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Container(
    //         height: double.infinity,
    //         padding: const EdgeInsets.all(16),
    //         decoration: const BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(18),
    //               topRight: Radius.circular(18),
    //             )),
    //         child: Column(
    //           children: <Widget>[
    //             Text(
    //               'Which cusiness should we include in your diet?',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             Text(
    //               'Seelect as many cuisines as you like',
    //               style: TextStyle(color: Colors.black38, fontSize: 16),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Profile Info',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: Screen(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  UploadImage(
                    name: 'avatar',
                    value: body['avatar'],
                    onChange: (
                        {String? value, String? name, File? file}) async {
                      if (value == null && name == null) return;

                      if (name != null) {
                        setState(() {
                          body[name] = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Input(
                    label: 'ProfileInfo.fullName'.tr(),
                    onFinish: onChangeFields,
                    name: 'fullName',
                    value: body['fullName'],
                  ),
                  const SizedBox(height: 10),
                  DropDown<String?>(
                    data: _genders,
                    selected: body['gender'],
                    label: 'gender'.tr(),
                    name: 'gender',
                    showText: (String? state) => Text(state.toString()),
                    onChange: onChangeFields,
                  ),
                  const SizedBox(height: 10),
                  Input(
                    keyboardType: TextInputType.number,
                    label: 'age'.tr(),
                    onFinish: onChangeFields,
                    name: 'age',
                    value: body['age'],
                  ),
                  // Button(
                  //   alignment: Alignment.centerLeft,
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   variant: Variant.outlined,
                  //   child: Container(
                  //     margin: const EdgeInsets.only(bottom: 30),
                  //     child: Text(
                  //       'Type Of Cuisine',
                  //       style: TextStyle(
                  //         color: Color.fromRGBO(196, 196, 196, 1),
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  //   onPress: onPressTypeOfCuisine,
                  // ),
                  DropDown<TypeOfCusines?>(
                    data: typeCusines,
                    selected: selectedTypeCusine,
                    label: 'Type Of Cuisine'.tr(),
                    name: 'typeOfCuisine',
                    showText: (TypeOfCusines? state) => Text(state!.name),
                    onChange: (
                        {TypeOfCusines? value, String? name, bool? isValid}) {
                      if (value != null && name != null) {
                        setState(() {
                          body = onChangeBody(value.id, name, body, isValid);
                          selectedTypeCusine = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  DropDown<FoodTypeModel?>(
                    showText: (FoodTypeModel? state) => Text(state!.name),
                    data: foodTypes,
                    label: 'Food Types',
                    selected: selectedFoodType,
                    name: 'foodType',
                    onChange: (
                        {FoodTypeModel? value, String? name, bool? isValid}) {
                      if (value != null && name != null) {
                        setState(() {
                          body = onChangeBody(value.id, name, body, isValid);
                          selectedFoodType = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 36),
                  Button(
                    onPress: onSubmit,
                    variant: Variant.primary,
                    label: 'ProfileInfo.updateInfo'.tr(),
                  ),
                  const SizedBox(height: 14),
                ]),
          ),
        ),
      ),
    );
  }
}

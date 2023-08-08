import 'package:flutter/material.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/resources/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cookley/resources/main.dart';
import '../navigation/tab_navigation.dart';

class TimeOfCooking extends StatefulWidget {
  const TimeOfCooking({super.key});

  @override
  State<TimeOfCooking> createState() => _TimeOfCookingState();
}

class _TimeOfCookingState extends State<TimeOfCooking> {
  String? dropdownValue;
  bool remindMe = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'categories'.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: Screen(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'TimeOfCooking.header'.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(161, 163, 170, 1),
                      ),
                    ),
                  ),
                  _renderList(
                    url: 'assets/images/breakfast.png',
                    title: 'Breakfast',
                    receipes: 289,
                    type: MealEnum.breakfast,
                  ),
                  _renderList(
                    url: 'assets/images/lunch.png',
                    title: 'Lunch',
                    receipes: 219,
                    type: MealEnum.lunch,
                  ),
                  _renderList(
                    url: 'assets/images/dinner.png',
                    title: 'Dinner',
                    receipes: 188,
                    type: MealEnum.dinner,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        remindMe = !remindMe;
                      });
                    },
                    child: Container(
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TimeOfCooking.reminder'.tr(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(159, 199, 39, 1))),
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: remindMe
                                    ? const Color.fromRGBO(159, 199, 39, 1)
                                    : Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Button(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabNavigation()),
                    );
                  },
                  variant: Variant.primary,
                  label: 'apply'.tr(),
                ),
              ),
              const SizedBox(height: 14),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _renderList({
  String? title,
  int? receipes,
  required String url,
  required MealEnum type,
}) {
  return Container(
    color: const Color.fromRGBO(246, 246, 246, 1),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: type.color,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 110,
          height: 80,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Image.asset(url),
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$title',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              Text('$receipes Recipes',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightGray)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: type.color.withOpacity(0.3),
          ),
          child: const Row(
            children: <Widget>[
              Text(
                '08:00 pm',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 10),
              Icon(Icons.edit, size: 14)
            ],
          ),
        ),
      ],
    ),
  );
}

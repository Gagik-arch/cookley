import 'package:flutter/material.dart';
import 'package:cookley/resources/main.dart';
import 'package:cookley/screens/main.dart';

import '../../core/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> body = {};
  final List<String> genderList = <String>['Male', 'Female'];
  String? selectedGender;

  void _onChangeDate({
    required String name,
  }) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    selectedTime.then((r) {
      setState(() {
        body[name] = r?.format(context);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 242, 201, 1),
        automaticallyImplyLeading: false,
        title: const Text('Profile Info',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Screen(
        padding: const EdgeInsets.all(20),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time of Breakfast',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray)),
            Button(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 10),
              variant: Variant.outlined,
              child: Text(body['brackfastTime'] != null
                  ? body['brackfastTime'].toString()
                  : 'Breakfast time'),
              onPress: () => _onChangeDate(name: 'brackfastTime'),
            ),
            const SizedBox(height: 16),
            Text('Time of Lunch',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray)),
            Button(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 10),
              variant: Variant.outlined,
              child: Text(body['lunchTime'] != null
                  ? body['lunchTime'].toString()
                  : 'LunchTime time'),
              onPress: () => _onChangeDate(name: 'lunchTime'),
            ),
            const SizedBox(height: 16),
            Text('Time of Dinner',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray)),
            Button(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 10),
              variant: Variant.outlined,
              child: Text(body['dinnerTime'] != null
                  ? body['dinnerTime'].toString()
                  : 'Dinner time'),
              onPress: () => _onChangeDate(name: 'dinnerTime'),
            ),
            const SizedBox(height: 16),
            Text('Time of Dinner',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray)),
            Input(),
            const SizedBox(height: 16),
            Text('Age',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray)),
            Input(),
            const SizedBox(height: 16),
            Text('Region',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray)),
            Input(),
          ],
        ),
      ),
    );
  }
}

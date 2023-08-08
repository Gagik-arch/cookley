import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/resources/main.dart';
import 'package:cookley/screens/main.dart';
import '../../components/main.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    void onDone() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MealScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 242, 201, 1),
        automaticallyImplyLeading: false,
        title: const Text('Meal Plan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
      body: Column(children: [
        MealPlanCalendar(
          selectedDate: _selectedDate,
          onPress: (DateTime date) {
            setState(() {
              _selectedDate = date;
            });
          },
        ),
        Expanded(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 17, bottom: 6, left: 23),
                child: Text(
                  'Breakfast',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              _renderList(
                type: MealEnum.breakfast,
                selectedDate: _selectedDate,
                onDone: onDone,
              ),
              const SizedBox(height: 10),
              _renderList(
                type: MealEnum.breakfast,
                selectedDate: _selectedDate,
                onDone: onDone,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 17, bottom: 6, left: 23),
                child: Text(
                  'Lunch',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              _renderList(
                type: MealEnum.lunch,
                selectedDate: _selectedDate,
                onDone: onDone,
              ),
              _renderList(
                type: MealEnum.lunch,
                selectedDate: _selectedDate,
                onDone: onDone,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 17, bottom: 6, left: 23),
                child: Text(
                  'Dinner',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              _renderList(
                type: MealEnum.dinner,
                selectedDate: _selectedDate,
                onDone: onDone,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget _renderList({
  required MealEnum type,
  required DateTime selectedDate,
  required void Function() onDone,
}) {
  bool isToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .compareTo(selectedDate) ==
          0;

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    color: const Color.fromRGBO(246, 246, 246, 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: 110,
              height: 110,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: type.color),
              child: Image.asset('assets/images/lunch.png', fit: BoxFit.cover),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: SvgPicture.asset(
                'assets/icons/favorite-fill.svg',
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Container(
          constraints: const BoxConstraints(
            minWidth: 1.0,
            maxWidth: 180,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Avocado and Tomato',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Calories',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '135.5g  7%',
                      style: TextStyle(
                          color: AppColor.lightGray,
                          fontSize: 8,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Protein',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '3g  5% ',
                      style: TextStyle(
                          color: AppColor.lightGray,
                          fontSize: 8,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Fat',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '9.19g 13%',
                      style: TextStyle(
                          color: AppColor.lightGray,
                          fontSize: 8,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Prep time:',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '20 minutes',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Button(
                width: double.infinity,
                alignment: Alignment.center,
                onPress: () {},
                variant: Variant.normal,
                label: 'Replace',
                backgroundColor: AppColor.lightGray,
                padding: const EdgeInsets.all(4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: AppColor.lightGray),
                textStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              if (isToday)
                Button(
                  width: double.infinity,
                  onPress: onDone,
                  variant: Variant.normal,
                  alignment: Alignment.center,
                  label: 'Done',
                  backgroundColor: AppColor.green,
                  padding: const EdgeInsets.all(4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: AppColor.green),
                  textStyle: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600),
                ),
            ],
          ),
        )
      ],
    ),
  );
}

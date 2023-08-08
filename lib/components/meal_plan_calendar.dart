import 'package:flutter/material.dart';
import 'package:cookley/core/button.dart';
import 'package:intl/intl.dart';

import '../resources/main.dart';

// ignore: must_be_immutable
class MealPlanCalendar extends StatelessWidget {
  MealPlanCalendar({
    super.key,
    required this.selectedDate,
    required this.onPress,
  });

  DateTime selectedDate;
  void Function(DateTime date) onPress;

  List<DateTime> calculateDays() {
    DateTime now = DateTime.now();
    List<DateTime> result = [];

    for (int i = now.day; i <= now.day + 7; i++) {
      DateTime date = DateTime(now.year, now.month, i);
      result.add(date);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ...calculateDays().map((DateTime item) {
            bool _selectedDate = item.compareTo(selectedDate) == 0;
            DateTime now = DateTime.now();
            DateTime date = DateTime(now.year, now.month, now.day);
            print(item.compareTo(date));
            return Expanded(
              child: Button(
                onPress: () => onPress(item),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.day.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _selectedDate
                              ? AppColor.green
                              : (item.compareTo(date) == 0
                                  ? const Color.fromRGBO(148, 163, 184, 1)
                                      .withOpacity(0.7)
                                  : Colors.black),
                        )),
                    Text(
                      DateFormat('EEEE')
                          .format(item)
                          .toString()
                          .substring(0, 3),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _selectedDate
                            ? AppColor.green
                            : (item.compareTo(date) == 0
                                ? const Color.fromRGBO(148, 163, 184, 1)
                                    .withOpacity(0.5)
                                : const Color.fromRGBO(148, 163, 184, 1)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}

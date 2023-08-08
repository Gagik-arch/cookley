import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cookley/resources/main.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cookley/screens/tab_screens/favorite.dart';
import 'package:cookley/screens/tab_screens/meal_plan.dart';
import 'package:cookley/screens/tab_screens/profile.dart';
import 'package:cookley/screens/tab_screens/recipies.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({super.key});

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    RecipiesScreen(),
    FavoriteScreen(),
    MealPlanScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 420),
        backgroundColor: Colors.transparent,
        color: const Color.fromRGBO(245, 245, 245, 1),
        buttonBackgroundColor: AppColor.green,
        items: <Widget>[
          renderItem(
            icon: 'assets/icons/bar.svg',
            isSelected: _selectedIndex == 0,
            label: 'recipes'.tr(),
          ),
          renderItem(
            icon: 'assets/icons/favorite.svg',
            isSelected: _selectedIndex == 1,
            label: 'favorites'.tr(),
          ),
          renderItem(
            icon: 'assets/icons/calendar.svg',
            isSelected: _selectedIndex == 2,
            label: 'mealPlan'.tr(),
          ),
          renderItem(
            icon: 'assets/icons/user.svg',
            isSelected: _selectedIndex == 3,
            label: 'profile'.tr(),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SafeArea(
        bottom: false,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

Widget renderItem({
  required bool isSelected,
  required String icon,
  required String label,
}) {
  return Container(
    child: Transform.translate(
      offset: isSelected ? Offset.zero : const Offset(0.0, 15.0),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            semanticsLabel: 'Label',
            height: 30,
            width: 30,
            fit: BoxFit.scaleDown,
            color: isSelected
                ? Colors.white
                : const Color.fromRGBO(214, 219, 222, 1),
          ),
          if (!isSelected)
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color.fromRGBO(214, 219, 222, 1)),
            )
        ],
      ),
    ),
  );
}

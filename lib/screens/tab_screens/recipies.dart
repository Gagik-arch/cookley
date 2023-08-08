import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cookley/components/main.dart';
import 'package:cookley/core/drop_down.dart';
import 'package:cookley/models/main.dart';

class RecipiesScreen extends StatefulWidget {
  const RecipiesScreen({super.key});

  @override
  State<RecipiesScreen> createState() => _RecipiesScreenState();
}

List<String> _filters = ['Male', 'Female'];
List<String> _sorts = ['sort 1 ', 'sort 2'];

class _RecipiesScreenState extends State<RecipiesScreen> {
  String? seletedFilter;
  Map<String, String> body = {};

  List<MealModel> data = <MealModel>[
    MealModel(title: 'Steak', subtitle: 'Steak, Boneless and Skinless'),
    MealModel(
        title: 'Vagetables', subtitle: 'Chicken Breast, Boneless and Skinless'),
    MealModel(
        title: 'Chicken & Pork',
        subtitle: 'Chicken Breast, Boneless and Skinless'),
    MealModel(
        title: 'Chicken & Pork',
        subtitle: 'Chicken Breast, Boneless and Skinless'),
    MealModel(
        title: 'Chicken & Pork',
        subtitle: 'Chicken Breast, Boneless and Skinless'),
    MealModel(
        title: 'Chicken & Pork',
        subtitle: 'Chicken Breast, Boneless and Skinless'),
    MealModel(
        title: 'Chicken & Pork',
        subtitle: 'Chicken Breast, Boneless and Skinless'),
  ];

  void _onChangeSelect({String? value, String? name}) {
    if (name != null && value != null) {
      setState(() {
        body[name] = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'recipes'.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SearchInput(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'RecepiesScreen.filterBy'.tr(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color.fromRGBO(147, 147, 147, 1),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: DropDown<String>(
                          data: _filters,
                          selected: body['sortBy'],
                          variant: VariantDropDown.primary,
                          name: 'sortBy',
                          onChange: _onChangeSelect,
                          showText: (String? value) => Text(value.toString(),
                              style: const TextStyle(fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 50, maxWidth: 100),
                        child: Text(
                          'RecepiesScreen.sortBy'.tr(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromRGBO(147, 147, 147, 1),
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropDown<String>(
                          data: _sorts,
                          selected: body['filterBy'],
                          variant: VariantDropDown.primary,
                          onChange: _onChangeSelect,
                          name: 'filterBy',
                          showText: (String? value) => Text(value.toString(),
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
                child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ReceptCard(
                  title: data[index].title,
                  subtitle: 'Steak, Boneless and Skinless',
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

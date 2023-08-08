import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cookley/resources/main.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../components/main.dart';
import '../../core/main.dart';
import '../../models/main.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String? seletedFilter;
  Map<String, String> body = {};

  List<MealModel> data = <MealModel>[
    MealModel(title: 'Steak', subtitle: 'Steak, Boneless and Skinless'),
    MealModel(
        title: 'Vagetables', subtitle: 'Chicken Breast, Boneless and Skinless'),
    MealModel(
        title: 'Chicken & Pork',
        subtitle: 'Chicken Breast, Boneless and Skinless'),
  ];

  void _onChangeSelect({String? name, String? value}) {
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
          'favorites'.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return ReceptCard(
                title: data[index].title,
                subtitle: 'Steak, Boneless and Skinless',
              );
            },
          )),
    );
  }
}

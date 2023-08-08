import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cookley/resources/app_colors.dart';

import '../core/main.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            backgroundColor: const Color.fromRGBO(231, 242, 201, 1),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/ice-cream.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    'SupportScreen.title'.tr(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Input(
                    keyboardType: TextInputType.number,
                    label: 'SupportScreen.inputPlaceholder'.tr(),
                  ),
                  const SizedBox(height: 30),
                  Button(
                    onPress: () {},
                    variant: Variant.primary,
                    label: 'submit'.tr(),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'SupportScreen.orConnectUsDirectly'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Button(
                    onPress: () {},
                    border: Border.all(width: 1, color: AppColor.lightGray),
                    borderRadius: BorderRadius.circular(20),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: AppColor.green,
                        ),
                        const SizedBox(width: 20),
                        Text('SupportScreen.emailUs'.tr(),
                            style: TextStyle(
                                color: AppColor.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

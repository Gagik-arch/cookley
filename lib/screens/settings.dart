import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cookley/core/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cookley/resources/main.dart';
import 'package:cookley/screens/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/main.dart';
import '../navigation/tab_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

List<Language> _languagesList = [
  Language(
    lang: 'english',
    locale: const Locale('en', 'US'),
    color: const Color(0xFFFFD374),
  ),
  Language(
    lang: 'हिंदी',
    locale: const Locale('hi', 'HI'),
    color: const Color(0xFFE7F2C9),
  ),
  Language(
    lang: 'corsiva',
    locale: const Locale('it', 'IT'),
    color: const Color(0xFFE7F2C9),
  ),
  Language(
    lang: 'francis',
    locale: const Locale('fr', 'FR'),
    color: const Color(0xFFF6C9C0),
  ),
];

class _SettingsScreenState extends State<SettingsScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => {print(123123)});
  // }

  @override
  Widget build(BuildContext context) {
    Language? selectedLanguage =
        _languagesList.firstWhere((e) => e.locale == context.locale);

    void setShared(Language item) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? locale = '${item.locale.languageCode}_${item.locale.countryCode}';

      await prefs.setString('locale', locale);
    }

    void updateLang({Language? value, String? name}) {
      if (value != null) {
        context.setLocale(value.locale);
        setShared(value);
        setState(() {
          selectedLanguage = value;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.lightBlue,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TabNavigation()),
                );
              },
            ),
            title: Text(
              'SettingsScreen.title'.tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Screen(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _renderList(
                  title: 'SettingsScreen.editProfil'.tr(),
                  subtitle: 'SettingsScreen.editYourProfileInformation'.tr(),
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileInfoScreen()),
                    );
                  },
                ),
                _renderList(
                  title: 'SettingsScreen.changeLanguage'.tr(),
                  subtitle: 'SettingsScreen.selectPreferredAppLanguage'.tr(),
                  onPress: () {},
                  rightRenderer: DropDown<Language>(
                    data: _languagesList,
                    selected: selectedLanguage,
                    variant: VariantDropDown.normal,
                    icon: SvgPicture.asset(
                      'assets/icons/chevron-down.svg',
                      color: AppColor.green,
                      width: 20,
                    ),
                    onChange: updateLang,
                    showText: (Language v) {
                      return Text(
                        v.lang.uppercaseFirstChar(),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: AppColor.lightGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      );
                    },
                  ),
                ),
                _renderList(
                  title: 'SettingsScreen.editItem'.tr(),
                  subtitle: 'Change  Time',
                  onPress: () {},
                ),
                const SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 24),
                    child: Text('SettingsScreen.support'.tr(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportScreen()),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 24),
                    child: Text('SettingsScreen.privacyPolicy'.tr(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 24),
                    child: Text('SettingsScreen.logout'.tr(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

Widget _renderList({
  required String title,
  String? subtitle,
  Widget? rightRenderer,
  required void Function() onPress,
}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: rightRenderer != null
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.lightGray,
                      fontWeight: FontWeight.w500,
                    ),
                  )
              ],
            ),
          ),
          rightRenderer != null
              ? Expanded(
                  child: Align(
                      alignment: Alignment.centerRight, child: rightRenderer))
              : Icon(
                  Icons.chevron_right_rounded,
                  color: AppColor.green,
                  size: 30.0,
                )
        ],
      ),
    ),
  );
}

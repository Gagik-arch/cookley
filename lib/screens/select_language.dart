import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/models/main.dart';
import 'package:cookley/resources/extentions.dart';
import 'package:cookley/screens/welcome.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    Locale? _character = context.locale;

    void setShared(Locale? item) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? locale = '${item!.languageCode}_${item.countryCode}';

      await prefs.setString('locale', locale);
    }

    void updateLang(Language item) {
      context.setLocale(item.locale);
      setState(() {
        _character = item.locale;
      });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'SelectLanguageScreen.title'.tr(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .38),
                  children: [
                    ..._langs.map((Language item) {
                      return GestureDetector(
                        onTap: () {
                          updateLang(item);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Radio<Locale>(
                                value: item.locale,
                                groupValue: _character,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                                onChanged: (value) {
                                  updateLang(item);
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.lang.uppercaseFirstChar())
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              Button(
                label: 'submit'.tr(),
                variant: Variant.primary,
                onPress: () {
                  setShared(_character);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Language> _langs = [
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

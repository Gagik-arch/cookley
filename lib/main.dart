import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/main.dart';
import 'navigation/stack_navigation.dart';
import 'resources/main.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await EasyLocalization.ensureInitialized();
    Locale? locale = await getLanguage();

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      webRecaptchaSiteKey: 'recaptcha-v3-site-key',
      androidProvider: AndroidProvider.debug,
    );
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('it', 'IT'),
          Locale('hi', 'HI'),
          Locale('fr', 'FR')
        ],
        path: 'assets/translations',
        fallbackLocale: locale ?? const Locale('en', 'US'),
        child: MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => UserController()),
        ], child: const App()),
      ),
    );
  } catch (e) {
    print(e);
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      routes: stackNavigation,
    );
  }
}

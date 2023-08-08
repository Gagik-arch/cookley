// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAPixwIjF1VJKCTL0mIERK36bzkYg6U-Ro',
    appId: '1:174614506994:web:c66df46dce839936e44f6b',
    messagingSenderId: '174614506994',
    projectId: 'recipe-ac5c8',
    authDomain: 'recipe-ac5c8.firebaseapp.com',
    databaseURL: 'https://recipe-ac5c8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'recipe-ac5c8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCq-OUkqFI9ZEcXWRR-k5IhuP7EOXFX60s',
    appId: '1:174614506994:android:cc0d29e4264c410fe44f6b',
    messagingSenderId: '174614506994',
    projectId: 'recipe-ac5c8',
    databaseURL: 'https://recipe-ac5c8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'recipe-ac5c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQuoFGL5wTGKxb355Bf4L_jyMc8iM7CKs',
    appId: '1:174614506994:ios:175f676abbb8b036e44f6b',
    messagingSenderId: '174614506994',
    projectId: 'recipe-ac5c8',
    databaseURL: 'https://recipe-ac5c8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'recipe-ac5c8.appspot.com',
    androidClientId: '174614506994-5f2pssmtgb4c6tq80qgh2htfaianebth.apps.googleusercontent.com',
    iosClientId: '174614506994-bm9v648lh8lgkuhdb8ilchd0qj05mh94.apps.googleusercontent.com',
    iosBundleId: 'com.example.cookly',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQuoFGL5wTGKxb355Bf4L_jyMc8iM7CKs',
    appId: '1:174614506994:ios:4b5f7c5e462d8b6be44f6b',
    messagingSenderId: '174614506994',
    projectId: 'recipe-ac5c8',
    databaseURL: 'https://recipe-ac5c8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'recipe-ac5c8.appspot.com',
    androidClientId: '174614506994-5f2pssmtgb4c6tq80qgh2htfaianebth.apps.googleusercontent.com',
    iosClientId: '174614506994-0fla41pfvpo69m0t23iq72evd8dv4860.apps.googleusercontent.com',
    iosBundleId: 'com.example.cookly.RunnerTests',
  );
}
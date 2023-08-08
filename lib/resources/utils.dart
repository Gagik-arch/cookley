import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';
import 'package:path_provider/path_provider.dart' as _platform;

Future<Locale?> getLanguage() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? locale = prefs.getString('locale')?.split('_');

    return locale != null ? Locale(locale[0], locale[1]) : null;
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  clear() {
    _timer?.cancel();
  }
}

Map<String, dynamic> onChangeBody<T>(
  String value,
  String name,
  Map<String, dynamic> body,
  bool? isValid,
) {
  Map<String, dynamic> bodyCopy = body;

  if (value == "") {
    bodyCopy.remove(name);
    return bodyCopy;
  }

  if (isValid != null) {
    if (isValid) {
      bodyCopy[name] = value;
    } else {
      bodyCopy.remove(name);
    }
  } else {
    bodyCopy[name] = value;
  }

  return bodyCopy;
}

Future<Directory?> getApplicationDocumentsDirectory() async {
  try {
    final Directory appDocumentsDir =
        await _platform.getApplicationDocumentsDirectory();

    if (appDocumentsDir.path == null) {
      print('Unable to get application documents directory');
    }
    return appDocumentsDir;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<String?> base64toFile(String string, String name) async {
  try {
    Uint8List bytes = base64.decode(string);

    String dir = (await getApplicationDocumentsDirectory())!.path;
    File file = File("$dir/" + name + ".png");
    await file.writeAsBytes(bytes);
    return file.path;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

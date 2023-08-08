import 'dart:ui';

import 'package:flutter/material.dart';

extension StringExt on String {
  String uppercaseFirstChar() {
    return this[0].toUpperCase() + substring(1);
  }
}

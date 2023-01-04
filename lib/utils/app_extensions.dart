import 'package:flutter/material.dart';

extension AppExt on BuildContext {
  TextTheme get $style => Theme.of(this).textTheme;
}

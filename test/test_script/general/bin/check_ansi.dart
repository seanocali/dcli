#! /usr/bin/env dcli

import 'dart:io';
import 'package:dcli/dcli.dart';

/// dcli script generated by:
/// dcli create check_ansi.dart
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

void main() {
  print('ansi supported: ${stdin.supportsAnsiEscapes}');
  print(red('I should be red'));
}

import 'package:dcli/dcli.dart';

/// GENERATED -- GENERATED
///
/// DO NOT MODIFIY
///
/// This script is generated via tool/build_templates.dart which is
/// called by pub_release (whicih runs any scripts in the  tool/pre_release_hook directory)
///
/// GENERATED - GENERATED

class TemplateExpander {
  String targetPath;
  TemplateExpander(this.targetPath);

  // ignore: non_constant_identifier_names
  void basic() {
    final expandTo = join(targetPath, 'basic.dart');
    // ignore: unnecessary_raw_strings
    expandTo.write(r'''
#! /usr/bin/env %dcliName%

import 'dart:io';
import 'package:dcli/dcli.dart';

import 'package:args/args.dart';

/// dcli script generated by:
/// dcli create %scriptname%
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

void main(List<String> args) {
  final parser = ArgParser();
  parser.addFlag(
    'verbose',
    abbr: 'v',
    negatable: false,
    help: 'Logs additional details to the cli',
  );

  parser.addOption('prompt', abbr: 'p', help: 'The prompt to show the user.');

  final parsed = parser.parse(args);

  if (parsed.wasParsed('verbose')) {
    Settings().setVerbose(enabled: true);
  }

  if (!parsed.wasParsed('prompt')) {
    printerr(red('You must pass a prompt'));
    showUsage(parser);
  }

  final prompt = parsed['prompt'] as String;

  var valid = false;
  String response;
  do {
    response = ask('$prompt:', validator: Ask.all([Ask.alpha, Ask.required]));

    valid = confirm('Is this your response? ${green(response)}');
  } while (!valid);

  print(orange('Your response was: $response'));
}

void showUsage(ArgParser parser) {
  print('Usage: %scriptname% -v -prompt <a questions>');
  print(parser.usage);
  exit(1);
}''');
  }

  // ignore: non_constant_identifier_names
  void pubspec() {
    final expandTo = join(targetPath, 'pubspec.yaml.template');
    // ignore: unnecessary_raw_strings
    expandTo.write(r'''
name: %scriptname%
version: 0.0.1
description: A script generated by dcli.
environment: 
  sdk: '>=2.9.0 <3.0.0'
dependencies: 
  args: ^1.0.0
  dcli: ^0.51.0
  path: ^1.0.0

dev_dependencies: 
  pedantic: ^1.0.0
''');
  }

  // ignore: non_constant_identifier_names
  void README() {
    final expandTo = join(targetPath, 'README.md');
    // ignore: unnecessary_raw_strings
    expandTo.write(r'''
This directory contains the templates used by dcli create

Eventually you will be able to run
 dcli create --template cli_args.dart snake.dart''');
  }

  // ignore: non_constant_identifier_names
  void hello_world() {
    final expandTo = join(targetPath, 'hello_world.dart');
    // ignore: unnecessary_raw_strings
    expandTo.write(r'''
#! /usr/bin/env %dcliName%

/// dcli script generated by:
/// dcli create $scriptname
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

void main() {
  print('Hello World');
}''');
  }

  // ignore: non_constant_identifier_names
  void cmd_args() {
    final expandTo = join(targetPath, 'cmd_args.dart');
    // ignore: unnecessary_raw_strings
    expandTo.write(r'''
#! /usr/bin/env %dcliName%

import 'dart:io';
import 'package:dcli/dcli.dart';

import 'package:args/args.dart';

/// dcli script generated by:
/// dcli create %scriptname%
///
/// See
/// https://pub.dev/packages/dcli#-installing-tab-
///
/// For details on installing dcli.
///

void main(List<String> args) {
  final parser = ArgParser();
  parser.addFlag(
    'verbose',
    abbr: 'v',
    negatable: false,
    help: 'Logs additional details to the cli',
  );

  parser.addOption('prompt', abbr: 'p', help: 'The prompt to show the user.');

  final parsed = parser.parse(args);

  if (parsed.wasParsed('verbose')) {
    Settings().setVerbose(enabled: true);
  }

  if (!parsed.wasParsed('prompt')) {
    printerr(red('You must pass a prompt'));
    showUsage(parser);
  }

  final prompt = parsed['prompt'] as String;

  var valid = false;
  String response;
  do {
    response = ask('$prompt:', validator: Ask.all([Ask.alpha, Ask.required]));

    valid = confirm('Is this your response? ${green(response)}');
  } while (!valid);

  print(orange('Your response was: $response'));
}

void showUsage(ArgParser parser) {
  print('Usage: %scriptname% -v -prompt <a questions>');
  print(parser.usage);
  exit(1);
}''');
  }

  // ignore: non_constant_identifier_names
  void analysis_options() {
    final expandTo = join(targetPath, 'analysis_options.yaml');
    // ignore: unnecessary_raw_strings
    expandTo.write(r'''

include: package:pedantic/analysis_options.yaml

# For lint rules and documentation, see http://dart-lang.github.io/linter/lints.
# Uncomment to specify additional rules.
linter:
  
  rules:
    lines_longer_than_80_chars: false
    camel_case_types: true
    always_declare_return_types: true
  

analyzer:
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false''');
  }

  void expand() {
    basic();
    pubspec();
    README();
    hello_world();
    cmd_args();
    analysis_options();
  }
}

import 'dart:io';
import 'dart:math';

import 'package:dshell/src/pubspec/pubspec_annotation.dart';

import '../functions/is.dart';
import 'flags.dart';
import '../util/file_helper.dart';
import 'package:path/path.dart' as p;

import '../settings.dart';
import 'command_line_runner.dart';

class Script {
  /// The directory where the script file lives
  /// stored as an absolute path.
  final String _scriptDirectory;

  /// Name of the dart script
  final String _scriptname;

  /// Creates a script object from a scriptArg
  /// passed to a command.
  ///
  /// The [scriptArg] may be a filename or
  /// a filename with a path prefix (relative or absolute)
  /// If the path is realtive then it will be joined
  /// with the current working directory to form
  /// a absolute path.
  ///
  Script.fromFile(
    String scriptArg,
  )   : _scriptname = _extractScriptname(scriptArg),
        _scriptDirectory = _extractScriptDirectory(scriptArg);

  /// the file name of the script including the extension.
  String get scriptname => _scriptname;

  /// the absolute path to the directory the script lives in
  String get scriptDirectory => _scriptDirectory;

  /// the absolute path of the script file.
  String get path => p.join(scriptDirectory, scriptname);

  /// the name of the script without its extension.
  /// this is used for the 'name' key in the pubspec.
  String get pubsecNameKey => p.basenameWithoutExtension(scriptname);

  /// The scriptname without its '.dart' extension.
  String get basename => p.basenameWithoutExtension(scriptname);

  String get pubSpecPath => p.join(_scriptDirectory, 'pubspec.yaml');

  // the scriptnameArg may contain a relative path: fred/home.dart
  // we need to get the actually name and full path to the script file.
  static String _extractScriptname(String scriptArg) {
    var cwd = Directory.current.path;

    return p.basename(p.join(cwd, scriptArg));
  }

  static String _extractScriptDirectory(String scriptArg) {
    var cwd = Directory.current.path;

    var scriptDirectory = p.canonicalize(p.dirname(p.join(cwd, scriptArg)));

    return scriptDirectory;
  }

  /// Generates the default scriptfile contents
  ///
  void createDefaultFile(String defaultBody) {
    writeToFile(path, defaultBody);
  }

  String generateDefaultBody() {
    /// The default body of the script we generate.
    return """#! /usr/bin/env ${Settings().appname}

import 'dart:io';
import 'package:dshell/dshell.dart';

/// dshell script generated by:
/// dshell create $scriptname
/// 
/// See 
/// https://pub.dev/packages/dshell#-installing-tab-
/// 
/// For details on installing dshell.
/// 

void main() {
  print('Hello World');
}
""";
  }

  /// validate that the passed arguments points to
  static void validate(String scriptPath) {
    if (!scriptPath.endsWith('.dart')) {
      throw InvalidArguments(
          'Expected a script name (ending in .dart) instead found: ${scriptPath}');
    }

    if (!exists(scriptPath)) {
      throw InvalidScript(
          'The script ${p.absolute(scriptPath)} does not exist.');
    }
    if (!FileSystemEntity.isFileSync(scriptPath)) {
      throw InvalidScript(
          'The script ${p.absolute(scriptPath)} is not a file.');
    }
  }

  void run(Map<String, Flag> selectedFlags, List<String> subarguments) {}

  /// Returns true if the script has a pubspec.yaml in its directory.
  bool hasPubSpecYaml() {
    // The virtual project pubspec.yaml file.
    final pubSpecPath = p.join(_scriptDirectory, 'pubspec.yaml');
    return exists(pubSpecPath);
  }

  bool _hasPubspecAnnotation;

  bool get hasPubspecAnnotation {
    if (_hasPubspecAnnotation == null) {
      var pubSpec = PubSpecAnnotation.fromScript(this);
      _hasPubspecAnnotation = pubSpec.annotationFound();
    }
    return _hasPubspecAnnotation;
  }
}

class PithyGreetings {
  static List<String> greeting = [
    'Hello World',
    'Helwo vorld',
    'Build and Ben flower pot men. Weeeeeeeed.',
    "I'm a little tea pot.",
    'Are we there yet.',
    'Hurry up, says Mr Blackboard',
    "Damed if you do, Damed if you don't, so just get the hell on with it.",
    'Yep, this is all of it.',
    "I don't like your curtains"
  ];

  /// returns a random pithy greeting.
  static String random() {
    var selected = Random().nextInt(greeting.length - 1);

    return greeting[selected];
  }
}

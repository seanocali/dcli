/* Copyright (C) S. Brett Sutton - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Brett Sutton <bsutton@onepub.dev>, Jan 2022
 */

import '../../dcli.dart';
import '../script/command_line_runner.dart';
import '../script/flags.dart';
import '../util/completion.dart';
import 'commands.dart';

/// Implementation for the 'clean' command.
/// The clean command removes all build artifiacts
/// including pubspec.lock, .packages, .dart_tools and
/// any compiled exes.
class CleanCommand extends Command {
  ///
  CleanCommand() : super(_commandName);

  static const String _commandName = 'clean';

  /// [arguments] contains path to clean
  @override
  int run(List<Flag> selectedFlags, List<String> arguments) {
    String targetPath;

    if (arguments.isEmpty) {
      targetPath = pwd;
    } else if (arguments.length != 1) {
      throw InvalidArgumentException(
        'Expected a single project path or no project path. '
        'Found ${arguments.length} ',
      );
    } else {
      targetPath = arguments[0];
    }

    _cleanProject(targetPath);
    return 0;
  }

  void _cleanProject(String targetPath) {
    if (!exists(targetPath)) {
      throw InvalidArgumentException(
          'The project path $targetPath does not exists.');
    }
    if (!isDirectory(targetPath)) {
      throw InvalidArgumentException('The project path must be a directory.');
    }

    final project = DartProject.fromPath(targetPath);

    print('');
    print(orange('Cleaning ${project.pathToProjectRoot} ...'));
    print('');

    project.clean();
  }

  @override
  String usage() => 'clean [<project path>]';

  @override
  String description({bool extended = false}) => '''
Removes all build artfiacts.
   If no directory is passed then the current directory is cleaned''';

  @override
  List<String> completion(String word) => completionExpandScripts(word);

  @override
  List<Flag> flags() => [];
}

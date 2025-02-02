@Timeout(Duration(minutes: 10))
/* Copyright (C) S. Brett Sutton - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Brett Sutton <bsutton@onepub.dev>, Jan 2022
 */

import 'package:dcli/dcli.dart';
import 'package:dcli/src/commands/install.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import '../util/test_file_system.dart';

void main() {
  group('Create Script ', () {
    test('Create script', () async {
      await TestFileSystem().withinZone((fs) async {
        InstallCommand().initTemplates();
        final scriptDir = join(fs.unitTestWorkingDir, 'traditional');

        const scriptName = 'extra.dart';
        final scriptPath = join(scriptDir, 'bin', scriptName);

        await withEnvironment(() async {
          'dcli create $scriptDir'.run;

          'dcli create $scriptPath'.run;
        }, environment: {
          DartProject.overrideDCliPathKey: DartProject.self.pathToProjectRoot
        });

        DartScript.fromFile(scriptPath).doctor;
      });
    });

    test('Create script with --template', () async {
      await TestFileSystem().withinZone((fs) async {
        InstallCommand().initTemplates();
        final scriptDir = join(fs.unitTestWorkingDir, 'traditional');

        const scriptName = 'extra.dart';
        final scriptPath = join(scriptDir, 'bin', scriptName);

        await withEnvironment(() async {
          'dcli create $scriptDir'.run;

          'dcli create --template=cmd_args $scriptPath'.run;
        }, environment: {
          DartProject.overrideDCliPathKey: DartProject.self.pathToProjectRoot
        });

        DartScript.fromFile(scriptPath).doctor;
      });
    });
  });
}

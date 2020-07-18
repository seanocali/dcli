import 'dart:io';

import 'package:dshell/dshell.dart';
import 'package:dshell/src/functions/run.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

import 'test_file_system.dart';

void main() {
  test('runnable process Start - forEach', () {
    TestFileSystem().withinZone((fs) async {
      var path = join(fs.root, 'top');
      print('starting ls in $path');

      String command;
      command = 'ls *.txt';
      var found = <String>[];
      start(command, workingDirectory: path).forEach((file) {
        found.add(file);
      });

      expect(found, <String>[
        join(path, 'one.txt'),
        //join(path, '.two.txt'), // we should not be expanding .xx.txt
        join(path, 'two.txt')
      ]);
    });
  });

  test('runnable process Start - forEach', () {
    print('Print to stdout using "print');

    stdout.writeln('Print to stdout using "stsdout.writeln"');

    stderr.writeln('Print to stderr using "stderr.writeln"');

    stderr.write('Print to stderr using "stderr.write"');
    stderr.write('\n');
    printerr('Print to stderr using "printerr"');
  });
}
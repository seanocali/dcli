// ignore_for_file: avoid_types_on_closure_parameters

/* Copyright (C) S. Brett Sutton - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Brett Sutton <bsutton@onepub.dev>, Jan 2022
 */

// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'dart:cli';

import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:stack_trace/stack_trace.dart';

Future<void> main() async {
  var future = startProcess();

  print('****************waitforMe *****************');
  waitForMe(future);

  future = startProcess();

  await waitForEx(future);
}

Future<Process> startProcess() => Process.start(
      'invalidcommandname',
      [],
    );

void waitForMe(Future<void> future) {
  try {
    future
        // ignore: discarded_futures
        .catchError((Object e, StackTrace st) => print('onError: $e'))
        // ignore: discarded_futures
        .whenComplete(() => print('future completed'));
    // print(waitFor<Process>(future));
    print(waitFor(future));
  }
  // ignore: avoid_catching_errors
  on AsyncError catch (e) {
    print('Rethrowing a non DCliException $e');
    rethrow;
  } on Exception catch (e) {
    print(e.toString());
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    print('Rethrowing a non DCliException $e');
    rethrow;
  } finally {
    print('waitForEx finally');
  }
}

Future<T> waitForEx<T>(Future<T> future) async {
  Object? exception;
  late T value;
  try {
    // catch any unhandled exceptions
    await future.catchError((Object e, StackTrace st) {
      print('catchError called');
      exception = e;
    }).whenComplete(() => print('future completed'));

    runZonedGuarded(() {
      value = waitFor<T>(future);
    }, (error, st) {
      exception = error;
    });
  }
  // ignore: avoid_catching_errors
  on AsyncError catch (e) {
    exception = e.error;
  } finally {
    print('exiting try');
  }

  if (exception != null) {
    // recreate the exception so we have a full
    // stacktrace rather than the microtask
    // stacktrace the future leaves us with.
    final stackTrace = Trace.current(2);

    if (exception is DCliException) {
      throw (exception! as DCliException)..stackTrace = stackTrace;
    } else {
      throw DCliException.from(exception, stackTrace);
    }
  }
  return value!;
}

Future<int> throwExceptionV3() {
  final complete = Completer<int>();
  try {
    Future.delayed(const Duration(seconds: 2), () => throw Exception())
        .catchError((Object e) {
      print('caught 1');
      complete.completeError('caught ');
    });
  }
  // ignore: avoid_catches_without_on_clauses
  catch (e) {
    print('e');
  }
  return complete.future;
}

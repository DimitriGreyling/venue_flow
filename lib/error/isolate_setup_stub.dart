import 'dart:isolate';

void setupIsolateErrorListener(void Function(Object, StackTrace?) report) {
  Isolate.current.addErrorListener(
    RawReceivePort((pair) {
      final values = pair as List<dynamic>;
      final error = values.first;
      final stack = StackTrace.fromString(values.last.toString());
      report(error, stack);
    }).sendPort,
  );
}
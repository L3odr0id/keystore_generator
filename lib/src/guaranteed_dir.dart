import 'dart:io';

import 'package:keystore_generator/src/pretty_log.dart';

class GuaranteedDir {
  final String dirName;
  final bool needAlert;

  const GuaranteedDir({
    required this.dirName,
    required this.needAlert,
  });

  void makeDir() {
    final dir = Directory(dirName);
    if (!dir.existsSync()) {
      if (needAlert) {
        throw LogError(
          info:
              '$dirName folder was not found in ${Directory.current.absolute.path}',
        ).decoratedMessage();
      } else {
        dir.createSync();
      }
    }
  }
}

import 'dart:io';

import 'package:keystore_generator/src/pretty_log.dart';

class GuaranteedDir {
  const GuaranteedDir({
    required this.dirName,
    required this.needAlert,
  });

  final String dirName;
  final bool needAlert;

  void makeDir() {
    final dir = Directory(dirName);
    if (!dir.existsSync()) {
      if (needAlert) {
        throw messageError(
          info:
              '$dirName folder was not found in ${Directory.current.absolute.path}',
        ).decoratedMessage();
      } else {
        dir.createSync();
      }
    }
  }
}

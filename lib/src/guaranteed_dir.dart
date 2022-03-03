import 'dart:io';

import 'package:keystore_generator/src/message.dart';

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
        throw MessageError(
          info:
              '$dirName folder was not found in ${Directory.current.absolute.path}',
        ).decoratedMessage();
      } else {
        dir.createSync();
      }
    }
  }
}

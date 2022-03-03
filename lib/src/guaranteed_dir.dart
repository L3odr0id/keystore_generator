import 'dart:io';

class GuaranteedDir {
  const GuaranteedDir({
    required this.dirName,
    required this.needAlert,
  });

  final String dirName;
  final bool needAlert;

  void makeDir() {
    Directory(dirName).createSync();
  }
}

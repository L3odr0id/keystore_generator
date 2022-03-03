import 'dart:io';

import 'package:keystore_generator/src/lines_to_add.dart';
import 'package:keystore_generator/src/writable_file.dart';

class BuildGradle extends WritableExistingFile {
  static final String pathToBuildGradle = './android/app/build.gradle';

  BuildGradle()
      : super(
          path: pathToBuildGradle,
          content: File(pathToBuildGradle).readAsLinesSync(),
        );

  void modify() {
    check();

    addLines(KeyPropertiesVariable());
    addLines(ReleaseConfig());
    addLines(SetReleaseConfig());
    write();
  }
}

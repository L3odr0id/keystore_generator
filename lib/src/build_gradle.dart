import 'dart:io';

import 'package:keystore_generator/src/lines_to_add.dart';
import 'package:keystore_generator/src/overridable_file.dart';
import 'package:keystore_generator/src/pretty_log.dart';
import 'package:keystore_generator/src/writable_file.dart';

class BuildGradle {
  final String pathToBuildGradle = './android/app/build.gradle';

  void modify() {
    // TODO Не менять градл, если уже есть конфигурация
    NonOverridableFile(path: pathToBuildGradle).check();

    WritableFile(
      content: File(pathToBuildGradle).readAsLinesSync(),
      path: pathToBuildGradle,
    )
      ..addLines(KeyPropertiesVariable())
      ..addLines(ReleaseConfig())
      ..addLines(SetReleaseConfig())
      ..write();
  }
}

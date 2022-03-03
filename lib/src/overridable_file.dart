import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/message.dart';

abstract class OverwritableFile {
  const OverwritableFile();
  void check();
}

class OptionalOverwritableFile extends OverwritableFile {
  const OptionalOverwritableFile({
    required this.path,
    required this.overwriteFlag,
  });

  final bool overwriteFlag;
  final String path;

  @override
  void check() {
    final file = File(path);
    if (file.existsSync()) {
      if (overwriteFlag) {
        file.deleteSync();
      } else {
        throw MessageInfo(
          info:
              'File ${Directory.current.absolute.path}${path.substring(1)} already exists! Use ${Arguments.overwriteOptionName} option if you want to override it',
        ).decoratedMessage();
      }
    }
  }
}

class AlwaysOverwritableFile extends OptionalOverwritableFile {
  const AlwaysOverwritableFile({
    required String path,
  }) : super(
          path: path,
          overwriteFlag: true,
        );
}

class NonOverwritableFile extends OverwritableFile {
  const NonOverwritableFile({
    required this.path,
  });

  final String path;

  @override
  void check() {
    final file = File(path);
    if (!file.existsSync()) {
      throw MessageError(
        info:
            '${Directory.current.absolute.path}/${path.substring(1)} does not exist',
      ).decoratedMessage();
    }
  }
}

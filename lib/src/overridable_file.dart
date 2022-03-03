import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/message.dart';

mixin OverwritableFile {
  void check();
}

class OptionalOverwritableFile with OverwritableFile {
  const OptionalOverwritableFile({
    required this.path,
    required this.arguments,
  });

  final Arguments arguments;
  final String path;

  @override
  void check() {
    final file = File(path);
    if (file.existsSync()) {
      if (arguments.overwriteFlag) {
        file.deleteSync();
      } else {
        throw MessageInfo(
          info:
              'File ${Directory.current.absolute.path}${path.substring(1)} already exists! Use ${arguments.overwriteOptionName} option if you want to override it',
        ).decoratedMessage();
      }
    }
  }
}

class AlwaysOverwritableFile with OverwritableFile {
  const AlwaysOverwritableFile({
    required this.path,
  });

  final String path;

  @override
  void check() {
    final file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}

class NonOverwritableFile with OverwritableFile {
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

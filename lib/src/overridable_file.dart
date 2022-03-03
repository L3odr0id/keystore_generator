import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/pretty_log.dart';

mixin OverridableFile {
  void check();
}

class OptionalOverridableFile with OverridableFile {
  const OptionalOverridableFile({
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
        throw messageInfo(
          info:
              'File ${Directory.current.absolute.path}${path.substring(1)} already exists! Use ${arguments.overwriteOptionName} option if you want to override it',
        ).decoratedMessage();
      }
    }
  }
}

class AlwaysOverridableFile with OverridableFile {
  const AlwaysOverridableFile({
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

class NonOverridableFile with OverridableFile {
  const NonOverridableFile({
    required this.path,
  });

  final String path;

  @override
  void check() {
    final file = File(path);
    if (!file.existsSync()) {
      throw messageError(
        info:
            '${Directory.current.absolute.path}/${path.substring(1)} does not exist',
      ).decoratedMessage();
    }
  }
}

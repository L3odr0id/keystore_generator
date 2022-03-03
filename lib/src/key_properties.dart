import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/guaranteed_dir.dart';
import 'package:keystore_generator/src/overridable_file.dart';

import 'constants.dart';

class KeyProperties {
  const KeyProperties({
    required this.arguments,
  });

  final Arguments arguments;
  final String keyPropertiesPath = './android/key.properties';

  void create() {
    GuaranteedDir(
      dirName: './android',
      needAlert: true,
    ).makeDir();

    AlwaysOverridableFile(
      path: keyPropertiesPath,
    ).check();

    File(keyPropertiesPath).writeAsStringSync(content);
  }

  String get content =>
      'storePassword=${arguments.password}\r\n' +
      'keyPassword=${arguments.password}\r\n' +
      'keyAlias=${arguments.alias}\r\n' +
      'storeFile=../../keys/$KEYSTORE_NAME\r\n';
}

import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/guaranteed_dir.dart';
import 'package:keystore_generator/src/overridable_file.dart';

import 'constants.dart';

class KeyProperties {
  final GuaranteedDir androidDir;
  final KeyPropertiesFile keyPropertiesFile;

  const KeyProperties({
    required this.arguments,
    required this.androidDir,
    required this.keyPropertiesFile,
  });

  final Arguments arguments;

  void create() {
    androidDir.makeDir();

    keyPropertiesFile.check();
    keyPropertiesFile.write(content);
  }

  String get content =>
      'storePassword=${arguments.password}\r\n' +
      'keyPassword=${arguments.password}\r\n' +
      'keyAlias=${arguments.alias}\r\n' +
      'storeFile=../../keys/$KEYSTORE_NAME\r\n';
}

class AndroidDir extends GuaranteedDir {
  AndroidDir()
      : super(
          dirName: './android',
          needAlert: true,
        );
}

class KeyPropertiesFile extends AlwaysOverwritableFile {
  static const String keyPropertiesPath = './android/key.properties';

  KeyPropertiesFile()
      : super(
          path: keyPropertiesPath,
        );

  void write(String content) {
    File(keyPropertiesPath).writeAsStringSync(content);
  }
}

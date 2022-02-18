import 'dart:io';

import 'package:keystore_generator/src/pretty_log.dart';

abstract class GradleModifier {
  static const String _keyLines = """
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
  keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
""";

  /// adds lines to enable release gradle config
  static void addSigningConfigStuff() {
    // TODO Не менять градл, если уже есть
    _checkIfExists();
    final List<String> lines = _getLines();
    for (var line in lines) {
      print(line);
    }
    final b = 1 + 1;
  }

  static void _checkIfExists() {
    final file = File('./android/app/build.gradle');
    if (!file.existsSync()) {
      throw PrettyLogger.log(
        '${Directory.current.absolute}/android/app/build.gradle does not exist',
      );
    }
  }

  static List<String> _getLines() {
    final file = File('./android/app/build.gradle');
    return file.readAsLinesSync();
  }
}

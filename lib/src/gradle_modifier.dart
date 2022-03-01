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

    addKeystorePropertiesVar(lines);

    final linesToWrite = List<String>.generate(
      lines.length,
      (i) => lines[i] + '\n',
    );
    write(linesToWrite.join());

    for (var line in lines) {
      // print(line);
    }
    final b = 1 + 1;
  }

  static void addKeystorePropertiesVar(List<String> lines) {
    if (lines.contains(
        "def keystorePropertiesFile = rootProject.file('key.properties')")) {
      print(
        PrettyLogger.logInfo(
          'You already have keystorePropertiesFile configuration in build.gradle',
        ),
      );
      return;
    }
    lines.insert(0, _keyLines);
  }

  /// is build.gradle exists
  static void _checkIfExists() {
    final file = File('./android/app/build.gradle');
    if (!file.existsSync()) {
      throw PrettyLogger.logError(
        '${Directory.current.absolute}/android/app/build.gradle does not exist',
      );
    }
  }

  static List<String> _getLines() {
    final file = File('./android/app/build.gradle');
    return file.readAsLinesSync();
  }

  static write(String content) {
    final file = File('./android/app/build.gradle');
    file.writeAsStringSync(content);
  }
}

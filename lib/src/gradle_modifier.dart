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

  static const String _signingConfigLines = """

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
""";

  /// adds lines to enable release gradle config
  static void addSigningConfigStuff() {
    // TODO Не менять градл, если уже есть
    _checkIfExists();
    final List<String> lines = _getLines();

    addKeystorePropertiesVar(lines);
    addReleaseBuildConfig(lines);
    setReleaseConfig(lines);

    final linesToWrite = List<String>.generate(
      lines.length,
      (i) => lines[i] + '\n',
    );
    write(linesToWrite.join());

    for (var line in lines) {
      // print(line + '${line.contains('signingConfig signingConfigs.debug')}');
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

  static void addReleaseBuildConfig(List<String> lines) {
    // find place to insert [_signingConfigLines]
    int indexOfBuildTypes = -1;
    for (int i = 0; i < lines.length; ++i) {
      if (lines[i].contains('buildTypes {')) {
        indexOfBuildTypes = i;
      }
    }

    // check if found
    if (indexOfBuildTypes == -1) {
      throw PrettyLogger.logError(
        'Impossible to find "buildTypes {" in build.gradle',
      );
    }

    lines.insert(indexOfBuildTypes, _signingConfigLines);
  }

  static void setReleaseConfig(List<String> lines) {
    bool changed = false;
    // find config line
    for (int i = 0; i < lines.length; ++i) {
      if (lines[i].contains('signingConfig signingConfigs.debug')) {
        lines[i].replaceAll('debug', 'release');
        changed = true;
      }
    }

    // check if found
    if (!changed) {
      throw PrettyLogger.logWarning(
        'Line "signingConfig signingConfigs.debug" was not found',
      );
    }
  }

  //signingConfig signingConfigs.debug

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

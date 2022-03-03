import 'package:keystore_generator/src/message.dart';

mixin LinesToAdd {
  void addLines(List<String> lines);
}

class KeyPropertiesVariable with LinesToAdd {
  const KeyPropertiesVariable();

  @override
  void addLines(List<String> lines) {
    if (lines.contains(
        "def keystorePropertiesFile = rootProject.file('key.properties')")) {
      print(
        MessageInfo(
          info:
              'You already have keystorePropertiesFile configuration in build.gradle',
        ).decoratedMessage(),
      );
      return;
    }
    lines.insert(0, """
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
  keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
""");
  }
}

class ReleaseConfig with LinesToAdd {
  const ReleaseConfig();

  @override
  void addLines(List<String> lines) {
    // find place to insert [_signingConfigLines]
    int indexOfBuildTypes = -1;
    for (int i = 0; i < lines.length; ++i) {
      if (lines[i].contains('buildTypes {')) {
        indexOfBuildTypes = i;
      }
    }

    // check if found
    if (indexOfBuildTypes == -1) {
      throw MessageError(
        info: 'Impossible to find "buildTypes {" in build.gradle',
      ).decoratedMessage();
    }

    lines.insert(indexOfBuildTypes, """

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
""");
  }
}

class SetReleaseConfig with LinesToAdd {
  const SetReleaseConfig();

  @override
  void addLines(List<String> lines) {
    bool changed = false;
    // find config line
    for (int i = 0; i < lines.length; ++i) {
      if (lines[i].contains('signingConfig signingConfigs.debug')) {
        lines[i] = lines[i].replaceAll('debug', 'release');
        changed = true;
      }
    }

    // check if found
    if (!changed) {
      throw MessageWarning(
        info: 'Line "signingConfig signingConfigs.debug" was not found',
      ).decoratedMessage();
    }
  }
}

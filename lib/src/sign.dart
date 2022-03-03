import 'package:keystore_generator/src/build_gradle.dart';
import 'package:keystore_generator/src/key_properties.dart';
import 'package:keystore_generator/src/keystore.dart';

/// Main class
class Sign {
  final Keystore keystore;
  final KeyProperties keyProperties;
  final BuildGradle buildGradle;

  Sign({
    required this.keystore,
    required this.keyProperties,
    required this.buildGradle,
  });

  /// Whole signing procedure
  void generate() {
    keystore.create();
    keyProperties.create();
    buildGradle.modify();
  }
}

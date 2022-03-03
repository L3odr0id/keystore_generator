import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/build_gradle.dart';
import 'package:keystore_generator/src/key_properties.dart';
import 'package:keystore_generator/src/keystore.dart';

/// Main class
class Sign {
  Sign({required this.arguments});

  final Arguments arguments;

  /// Whole signing procedure
  void generate() {
    Keystore(arguments: arguments).create();
    KeyProperties(arguments: arguments).create();
    BuildGradle().modify();
  }
}

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/build_gradle.dart';
import 'package:keystore_generator/src/key_properties.dart';
import 'package:keystore_generator/src/keystore.dart';
import 'package:keystore_generator/src/sign.dart';

Future<void> main(List<String> args) async {
  // cli arguments
  final arguments = Arguments(args: args);

  Sign(
    keystore: Keystore(arguments: arguments),
    keyProperties: KeyProperties(arguments: arguments),
    buildGradle: BuildGradle(),
  ).generate();
}

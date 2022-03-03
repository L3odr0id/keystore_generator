import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/build_gradle.dart';
import 'package:keystore_generator/src/key_properties.dart';
import 'package:keystore_generator/src/keystore.dart';
import 'package:keystore_generator/src/keytool_process.dart';
import 'package:keystore_generator/src/sign.dart';

/// main function that does all the work
Future<void> main(List<String> args) async {
  final Arguments arguments = Arguments(args: args);

  Sign(
    keystore: Keystore(
      keysDir: KeysDir(),
      keytoolProcess: KeytoolProcess(
        arguments: arguments,
        keystoreFile: KeystoreFile(
          arguments: arguments,
        ),
      ),
    ),
    keyProperties: KeyProperties(
      androidDir: AndroidDir(),
      keyPropertiesFile: KeyPropertiesFile(),
      arguments: arguments,
    ),
    buildGradle: BuildGradle(),
  ).generate();
}

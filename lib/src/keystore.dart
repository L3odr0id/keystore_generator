import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/keytool_process.dart';
import 'package:keystore_generator/src/overridable_file.dart';

import 'constants.dart';
import 'guaranteed_dir.dart';

class Keystore {
  final GuaranteedDir keysDir;
  final RunnableProcess keytoolProcess;

  const Keystore({
    required this.keysDir,
    required this.keytoolProcess,
  });

  // keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  Future<void> create() async {
    keysDir.makeDir();
    keytoolProcess.run();
  }
}

class KeysDir extends GuaranteedDir {
  KeysDir()
      : super(
          dirName: 'keys',
          needAlert: false,
        );
}

class KeystoreFile extends OptionalOverwritableFile {
  KeystoreFile({
    required Arguments arguments,
  }) : super(
          path: filePath,
          overwriteFlag: arguments.overwriteFlag,
        );

  static const String filePath = './keys/$KEYSTORE_NAME';
}

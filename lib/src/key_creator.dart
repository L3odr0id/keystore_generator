import 'dart:io';

import 'package:keystore_generator/src/pretty_log.dart';

class KeyCreator {
  final String alias;
  final String password;

  const KeyCreator({
    required this.alias,
    required this.password,
  });

  void _createKeyDir() {
    final dir = Directory('keys');
    if (!dir.existsSync()) {
      dir.createSync();
    }
  }

  // keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  Future<void> create() async {
    _createKeyDir();

    final res = await Process.run('keytool', [
      '-genkey',
      '-v',
      '-keystore',
      './keys/upload-keystore.keystore',
      '-alias',
      alias,
      '-keypass',
      password,
      '-storepass',
      password,
      '-keyalg',
      'RSA',
      '-keysize',
      '2048',
      '-validity',
      '10000',
      '-dname',
      'CN=ClientName, OU=OrganizationUnit, O=Organization, L=Locality, S=State, C=CountryCode',
    ]);

    if (res is String) {
      throw PrettyLogger.log(
        'Error while creating a keystore. \nOutput:${res.stdout}',
      );
    }
  }
}

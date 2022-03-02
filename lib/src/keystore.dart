import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/overridable_file.dart';
import 'package:keystore_generator/src/pretty_log.dart';

import 'constants.dart';
import 'guaranteed_dir.dart';

class Keystore {
  final Arguments arguments;
  const Keystore({
    required this.arguments,
  });

  final keystorePath = './keys/$KEYSTORE_NAME';

  // keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  Future<void> create() async {
    GuaranteedDir(
      dirName: 'keys',
      needAlert: false,
    ).makeDir();

    OptionalOverridableFile(
      path: keystorePath,
      arguments: arguments,
    ).check();

    final res = await Process.run('keytool', [
      '-genkey',
      '-v',
      '-keystore',
      keystorePath,
      '-alias',
      arguments.alias,
      '-keypass',
      arguments.password,
      '-storepass',
      arguments.password,
      '-keyalg',
      'RSA',
      '-keysize',
      '2048',
      '-validity',
      '10000',
      '-dname',
      'CN=ClientName, OU=OrganizationUnit, O=Organization, L=Locality, S=State, C=CountryCode',
    ]);
    // print('KEY CREATOR exit code: ${res.exitCode}');
    if (res.stdout is String && (res.stdout as String).isNotEmpty) {
      throw LogError(
        info: 'Bad keystore creating operation',
        moreInfo: res.stdout,
      ).decoratedMessage();
    }
  }
}

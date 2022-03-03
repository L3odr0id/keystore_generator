import 'dart:io';

import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/keystore.dart';

import 'message.dart';

abstract class RunnableProcess {
  const RunnableProcess();

  void run();
}

class KeytoolProcess extends RunnableProcess {
  const KeytoolProcess({
    required this.arguments,
    required this.keystoreFile,
  }) : super();

  final Arguments arguments;
  final KeystoreFile keystoreFile;

  @override
  Future<void> run() async {
    keystoreFile.check();

    final res = await Process.run('keytool', [
      '-genkey',
      '-v',
      '-keystore',
      keystoreFile.path,
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
      throw MessageError(
        info: 'Bad keystore creating operation',
        moreInfo: res.stdout,
      ).decoratedMessage();
    }
  }
}

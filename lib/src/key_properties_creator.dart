import 'dart:io';

import 'package:keystore_generator/src/constants.dart';
import 'package:keystore_generator/src/pretty_log.dart';

/// storePassword=<password from previous step>
/// keyPassword=<password from previous step>
/// keyAlias=upload
/// storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
class KeyPropertiesBuilder {
  final String storePassword;
  final String keyPassword;
  final String keyAlias;

  const KeyPropertiesBuilder({
    required this.keyAlias,
    required this.keyPassword,
    required this.storePassword,
  });

  void createFile() {
    // check if directory exists
    final dir = Directory('./android');
    if (!dir.existsSync()) {
      throw PrettyLogger.logError(
        'Error: "android" folder was not found in ${Directory.current.absolute}',
      );
    }

    // prepare file
    final file = File('./android/key.properties');
    if (file.existsSync()) {
      file.deleteSync();
    }

    // write stuff
    file.writeAsStringSync(_content);
  }

  String get _content =>
      'storePassword=$storePassword\r\n' +
      'keyPassword=$keyPassword\r\n' +
      'keyAlias=$keyAlias\r\n' +
      'storeFile=../../keys/$KEYSTORE_NAME\r\n';
}

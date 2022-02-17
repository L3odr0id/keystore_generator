import 'dart:developer';

import 'package:keystore_generator/src/arg_parser.dart';
import 'package:keystore_generator/src/key_creator.dart';
import 'package:keystore_generator/src/key_properties_creator.dart';

Future<void> main(List<String> args) async {
  // parse alias and pass
  final parser = ArgParser(args: args);

  print('${parser.alias}');
  print('${parser.password}');

  final alias = parser.alias;
  final password = parser.password;

  // create keystore
  final keyGen = KeyCreator(
    alias: alias,
    password: password,
  );
  await keyGen.create();

  // create key.properties
  final propertiesBuilder = KeyPropertiesBuilder(
    keyAlias: alias,
    keyPassword: password,
    storePassword: password,
  );
  propertiesBuilder.createFile();

  // write signins config to build.gradle
  
}

import 'dart:developer';

import 'package:keystore_generator/src/arg_parser.dart';
import 'package:keystore_generator/src/key_creator.dart';

Future<void> main(List<String> args) async {
  log('message');

  final parser = ArgParser(args: args);

  print('${parser.alias}');
  print('${parser.password}');

  final keyGen = KeyCreator(alias: parser.alias, password: parser.password);
  await keyGen.create();
}

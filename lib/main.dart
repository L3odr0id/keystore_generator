import 'package:keystore_generator/src/arguments.dart';
import 'package:keystore_generator/src/sign.dart';

Future<void> main(List<String> args) async {
  Sign(
    arguments: Arguments(args: args),
  ).generate();
}

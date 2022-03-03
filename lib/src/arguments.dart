import 'package:keystore_generator/src/message.dart';

///Make sure that the login and password arguments are passed
class Arguments {
  const Arguments({
    required this.args,
  });

  final List<String> args;
  final String overwriteOptionName = '-y';

  String getValueByOption(String option) {
    final pos = args.indexOf(option);
    if (pos == -1) {
      throw MessageError(info: 'Option $option not found').decoratedMessage();
    }
    if (args.length <= pos + 1) {
      throw MessageError(info: 'Option $option was not provided')
          .decoratedMessage();
    }
    return args[pos + 1];
  }

  String get alias => getValueByOption('-a');

  String get password => getValueByOption('-p');

  bool get overwriteFlag => args.contains(overwriteOptionName);
}

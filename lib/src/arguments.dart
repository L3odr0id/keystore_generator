import 'package:keystore_generator/src/pretty_log.dart';

///Make sure that the login and password arguments are passed
class Arguments {
  final List<String> args;

  const Arguments({
    required this.args,
  });

  String getValueByOption(String option) {
    final pos = args.indexOf(option);
    if (pos == -1) {
      throw LogError(info: 'Option $option not found').decoratedMessage();
    }
    if (args.length <= pos + 1) {
      throw LogError(info: 'Option $option was not provided')
          .decoratedMessage();
    }
    return args[pos + 1];
  }

  String get alias => getValueByOption('-a');
  String get password => getValueByOption('-p');
  bool get overwriteFlag => args.contains(overwriteOptionName);

  final String overwriteOptionName = '-y';
}

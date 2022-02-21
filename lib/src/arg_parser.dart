import 'package:keystore_generator/src/pretty_log.dart';

///Make sure that the login and password arguments are passed
class Arguments {
  final List<String> args;

  const Arguments({
    required this.args,
  });

  String _getValueByOption(String option) {
    final pos = args.indexOf(option);
    if (pos == -1) {
      throw PrettyLogger.log('Option $option not found');
    }
    if (args.length <= pos + 1) {
      throw PrettyLogger.log('Option $option was not provided');
    }
    return args[pos + 1];
  }

  String get alias => _getValueByOption('-a');
  String get password => _getValueByOption('-p');
}

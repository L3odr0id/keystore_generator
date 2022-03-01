abstract class PrettyLogger {
  static String logError(String msg) {
    final String info = 'Error: $msg';
    return '\n╔' +
        _divider(info) +
        '╗\n║ ' +
        info +
        ' ║\n╚' +
        _divider(info) +
        '╝\n';
  }

  static String _divider(String stringToWrap) {
    return '═' * (stringToWrap.length + 2);
  }
}

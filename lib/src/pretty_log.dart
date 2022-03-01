abstract class PrettyLogger {
  static String logInfo(String msg, {String moreInfo = ''}) {
    final String info = 'Info: $msg';
    return log(
      info,
      moreInfo: moreInfo,
    );
  }

  static String logWarning(String msg, {String moreInfo = ''}) {
    final String info = 'Warning: $msg';
    return log(
      info,
      moreInfo: moreInfo,
    );
  }

  static String log(String info, {String moreInfo = ''}) {
    return '\n╔' +
        _divider(info) +
        '╗\n║ ' +
        info +
        ' ║\n╚' +
        _divider(info) +
        '╝\n' +
        moreInfo;
  }

  static String logError(String msg, {String moreInfo = ''}) {
    final String info = 'Error: $msg';
    return log(
      info,
      moreInfo: moreInfo,
    );
  }

  static String _divider(String stringToWrap) {
    return '═' * (stringToWrap.length + 2);
  }
}

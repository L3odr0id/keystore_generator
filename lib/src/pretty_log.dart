class Log {
  final String info;
  final String moreInfo;
  const Log({
    required this.info,
    this.moreInfo = '',
  });

  String decoratedMessage() {
    return '\n╔' +
        divider(info) +
        '╗\n║ ' +
        info +
        ' ║\n╚' +
        divider(info) +
        '╝\n' +
        moreInfo;
  }

  String divider(String stringToWrap) {
    return '═' * (stringToWrap.length + 2);
  }
}

class LogError extends Log {
  const LogError({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Error: $info',
          moreInfo: moreInfo,
        );
}

class LogWarning extends Log {
  const LogWarning({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Warning: $info',
          moreInfo: moreInfo,
        );
}

class LogInfo extends Log {
  const LogInfo({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Info: $info',
          moreInfo: moreInfo,
        );
}

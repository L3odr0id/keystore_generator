class Message {
  const Message({
    required this.info,
    this.moreInfo = '',
  });

  final String info;
  final String moreInfo;

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

class messageError extends Message {
  const messageError({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Error: $info',
          moreInfo: moreInfo,
        );
}

class messageWarning extends Message {
  const messageWarning({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Warning: $info',
          moreInfo: moreInfo,
        );
}

class messageInfo extends Message {
  const messageInfo({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Info: $info',
          moreInfo: moreInfo,
        );
}

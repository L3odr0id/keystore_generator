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

class MessageError extends Message {
  const MessageError({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Error: $info',
          moreInfo: moreInfo,
        );
}

class MessageWarning extends Message {
  const MessageWarning({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Warning: $info',
          moreInfo: moreInfo,
        );
}

class MessageInfo extends Message {
  const MessageInfo({
    required String info,
    String moreInfo = '',
  }) : super(
          info: 'Info: $info',
          moreInfo: moreInfo,
        );
}

abstract class PrettyLogger {
  static String log(String info) {
    return _divider + info + _divider;
  }

  static const String _divider = '\n------\n';
}

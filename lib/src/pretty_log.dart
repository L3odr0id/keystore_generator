abstract class PrettyLogger {
  static String log(String info) {
    return divider + info + divider;
  }

  static const String divider = '\n------\n';
}

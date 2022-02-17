import 'dart:io';

abstract class GradleModifier {
  /// adds lines to enable release gradle config
  static void addSigningConfigStuff() {
    // TODO Не менять градл, если уже есть
    _checkIfExists();
  }

  static void _checkIfExists() {
    final file = File('./android/app/build.gradle');
    if (!file.existsSync()) {}
  }
}

import 'dart:io';

import 'package:keystore_generator/src/lines_to_add.dart';

class WritableFile {
  final List<String> content;
  final String path;

  const WritableFile({
    required this.content,
    required this.path,
  });

  void addLines(LinesToAdd linesObj) {
    linesObj.addLines(content);
  }

  void write() {
    final linesToWrite = List<String>.generate(
      content.length,
      (i) => content[i] + '\n',
    );
    File(path).writeAsStringSync(linesToWrite.join());
  }
}

import 'dart:io';

import 'package:keystore_generator/src/lines_to_add.dart';

/// Write content into file
class WritableFile {
  const WritableFile({
    required this.content,
    required this.path,
  });

  final List<String> content;
  final String path;

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

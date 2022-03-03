import 'dart:io';

import 'package:keystore_generator/src/lines_to_add.dart';
import 'package:keystore_generator/src/overridable_file.dart';

/// Write content into file, that exactly exists
class WritableExistingFile extends NonOverwritableFile {
  const WritableExistingFile({
    required this.content,
    required this.path,
  }) : super(path: path);

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

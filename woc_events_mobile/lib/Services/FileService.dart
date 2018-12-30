import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> readFile(String filename) async {
    try {
      final file = await _localFile(filename);
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future writeFile(String filename, String content) async {
    try {
      final file = await _localFile('events.json');
      file.writeAsString(content);
    } catch (e) {
      return null;
    }
  }
}

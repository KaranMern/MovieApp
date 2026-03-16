import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogFileManager {

  static const int maxFileSize = 1024 * 1024; // 1MB

  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/app_logs.txt');
  }

  static Future<void> writeLog(String log) async {

    final file = await _getFile();

    if (await file.exists()) {

      final size = await file.length();

      if (size > maxFileSize) {
        await file.writeAsString(""); // clear old logs
      }
    }

    await file.writeAsString(
      "${DateTime.now()} : $log\n",
      mode: FileMode.append,
    );
  }

  static Future<String> getLogs() async {

    final file = await _getFile();

    if (await file.exists()) {
      return await file.readAsString();
    }

    return "";
  }
}
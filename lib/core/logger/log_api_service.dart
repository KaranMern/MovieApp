import 'package:dio/dio.dart';
import 'log_file_manager.dart';

class LogApiService {

  static final Dio dio = Dio();

  static Future<void> sendLogs() async {

    final logs = await LogFileManager.getLogs();

    await dio.post(
      "https://your-api.com/logs",
      data: {
        "logs": logs
      },
    );
  }

}
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RequestHelper {
  static Dio dio = Dio(BaseOptions(connectTimeout: 10000));

  static void addLogger() {
    if (dio.interceptors.isEmpty)
      dio.interceptors.add(
        PrettyDioLogger(
          request: false,
          requestBody: true,
          responseBody: false,
          compact: false,
        ),
      );
  }

  static Future<dynamic> getRequest(Uri uri) async {
    addLogger();
    final response = await dio.getUri(uri);
    try {
      if (response.statusCode == 200) {
        return response.data;
      } else
        return 'failed';
    } catch (e) {
      return 'failed';
    }
  }

  static Future<bool> downloadImage(String url, String savePath) async {
    addLogger();
    final response = await dio.download(url, savePath);
    try {
      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }
}

import 'package:dio/dio.dart';

class FileService {
  static Future<String> downloadFile() async {
    Dio dio = Dio();

    try {
      String downloadsDirectory =
          "C:/Develop Folder/Mobile/isolate_with_flutter/downloads";
      String savePath = '$downloadsDirectory/my_file.pdf';

      await dio.download("http://10.0.2.198:3000/", savePath);

      return 'File downloaded to: $savePath';
    } on DioError catch (e) {
      return 'Error occurred during download: $e';
    }
  }
}

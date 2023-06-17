import 'package:dio/dio.dart';

class CurrencyService {
  static Future<dynamic> getCurrencyService() async {
    try {
      Response response =
          await Dio().get("https://nbu.uz/uz/exchange-rates/json/");
      if (response.statusCode == 200) {
        return (response.data);
      } else {
        return response.statusMessage.toString();
      }
    } on DioError catch (e) {
      return e.message.toString();
    }
  }
}

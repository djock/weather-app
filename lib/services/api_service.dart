import 'package:dio/dio.dart';

abstract class ApiService {
  ApiService();
  Future get(String url, {Map<String, String>? params, dynamic headers}) async {
    try {
      Dio dio = Dio(
        BaseOptions(
          baseUrl: url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      var resp = await dio.get(url + paramsToString(params), options: Options(headers: headers));

      return resp.data;
    } on DioError catch (e) {
      throw(e.message.toString());
    }
  }

  static String paramsToString(Map<String, String>? params) {
    if (params == null) return "";
    String output = "?";
    params.forEach((key, value) {
      output += "$key=$value&";
    });
    return output.substring(0, output.length - 1);
  }
}
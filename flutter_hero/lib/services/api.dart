import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  Future<Response?> RegisteredUser(Map req) async {
    try {
      await dotenv.load();
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().post("$BaseURL/user/register", data: req);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}

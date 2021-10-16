import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
//https://retail.amit-learning.com/api/login
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://retail.amit-learning.com/',
          receiveDataWhenStatusError: true),
    );
  }




  static Future<Response> getData(@required String url) async {
    return await dio.get(url);
  }


}

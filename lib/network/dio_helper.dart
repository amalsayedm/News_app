import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  static Dio dio;
  static init(){
    dio=Dio(BaseOptions(baseUrl: 'https://newsapi.org/',receiveDataWhenStatusError: true),);
  }

static Future<Response> getData({@required String path,@required query}) async
 {

    return await dio.get(path,queryParameters: query);
  }
}
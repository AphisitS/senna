import 'dart:convert';

import 'package:dio/dio.dart';
const PERF_aToken = 'accessToken';
const PERF_rToken = 'refreshToken';
class ApiService {
  Dio dio = Dio();

  Future getApiService(String _path) async {
    var respone = await dio.get(_path);
    print(respone.statusCode);
    if(respone.statusCode ==200 ){
      return respone.data;
    }
  }
}

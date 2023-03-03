import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/constants.dart';

abstract class ApiService {
  final BuildContext context;

  Dio get _dio => Dio(
    BaseOptions(
      baseUrl: endpoint,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  ApiService(this.context);

  ///if pure == true, it will return data without parse it to ApiResponse
  Future get(String url, {Map<String, String>? params, dynamic headers, bool pure = true, bool showDebug = false}) async {
    try {
      headers = _preRequest(headers);
      var resp = await _dio.get(url + paramsToString(params), options: Options(headers: headers));

      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  ///if pure == true, it will return data without parse it to ApiResponse
  Future post(String url, {Map<String, String>? params, dynamic body, dynamic headers, bool pure = true, bool showDebug = false}) async {
    try {
      headers = _preRequest(headers);

      var resp = await _dio.post(url + paramsToString(params), data: body, options: Options(headers: headers));

      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  ///if pure == true, it will return data without parse it to ApiResponse
  Future put(String url, {Map<String, String>? params, dynamic body, dynamic headers, bool pure = true, bool showDebug = false}) async {
    try {
      headers = _preRequest(headers);
      var resp = await _dio.put(url + paramsToString(params), data: body, options: Options(headers: headers));
      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  ///if pure == true, it will return data without parse it to ApiResponse
  Future delete(String url, {Map<String, String>? params, dynamic body, dynamic headers, bool pure = true, bool showDebug = false}) async {
    try {
      headers = _preRequest(headers);
      var resp = await _dio.delete(url + paramsToString(params), data: body, options: Options(headers: headers));
      return resp.data;
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      return null;
    }
  }

  ///Add something before request, you can simply manipulate headers or anyting in here
  ///And got called before request called
  ///
  ///for an Example :
  Map<String, String>? _preRequest(Map<String, String>? headers) {
    return headers;
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
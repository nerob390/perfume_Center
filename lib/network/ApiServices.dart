import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import '../utlis/MyProgressDialog.dart'; // Import your progress dialog class
import '../utlis/utlis.dart';
import 'AppException.dart';
import 'LoggingInterceptor.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  final http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      MyProgressDialog.show(message: ""); // Show loading dialog
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      Utils.logger.e("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } finally {
      MyProgressDialog.hide(); // Hide loading dialog
    }

    return responseJson;
  }

  @override
  Future<dynamic> getApiWoocommerce(String url) async {
    if (kDebugMode) {
      print(url);
    }
    final urlGet = Uri.parse(url)
        .replace(query: 'consumer_key=ck_9682c7e0238c42b909f85dad37f757163281721c&consumer_secret=cs_1cb03ae4ad13783b0909005b461abf72dcc19ed8');
    dynamic responseJson;
    try {
      MyProgressDialog.show(message: ""); // Show loading dialog
      final response = await client.get(urlGet).timeout(const Duration(seconds: 60));
      Utils.logger.e("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } finally {
      MyProgressDialog.hide(); // Hide loading dialog
    }

    return responseJson;
  }
  @override
  Future<dynamic> getApiWoocommerceProduct(String url,String pageNo) async {
    if (kDebugMode) {
      print(url);
    }
    final urlGet = Uri.parse(url)
        .replace(query: 'page=$pageNo&consumer_key=ck_9682c7e0238c42b909f85dad37f757163281721c&consumer_secret=cs_1cb03ae4ad13783b0909005b461abf72dcc19ed8');
    dynamic responseJson;
    try {
      MyProgressDialog.show(message: ""); // Show loading dialog
      final response = await client.get(urlGet).timeout(const Duration(seconds: 60));
      Utils.logger.e("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } finally {
      MyProgressDialog.hide(); // Hide loading dialog
    }

    return responseJson;
  }
  @override
  Future<dynamic> getApiWoocommerceProductCategory(String url,String category,String pageNo,String perPage) async {
    if (kDebugMode) {
      print(url);
    }
    final urlGet = Uri.parse(url)
        .replace(query: 'category=$category&page=$pageNo&per_page=$perPage&consumer_key=ck_9682c7e0238c42b909f85dad37f757163281721c&consumer_secret=cs_1cb03ae4ad13783b0909005b461abf72dcc19ed8');
    dynamic responseJson;
    try {
      MyProgressDialog.show(message: ""); // Show loading dialog
      final response = await client.get(urlGet).timeout(const Duration(seconds: 60));
      Utils.logger.e("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } finally {
      MyProgressDialog.hide(); // Hide loading dialog
    }

    return responseJson;
  }
  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      MyProgressDialog.show(message: "Loading..."); // Show loading dialog
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      ).timeout(const Duration(seconds: 60));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } finally {
      MyProgressDialog.hide(); // Hide loading dialog
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException('');
      default:
        Utils.toastMessageCenter('Error while communication to server ${response.statusCode}');
        throw FetchDataException('Error while communication to server ${response.statusCode}');

    }
  }
}

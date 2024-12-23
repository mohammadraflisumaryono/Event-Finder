
// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:io';
import 'package:event_finder/data/app_exceptions.dart';
import 'package:event_finder/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiService extends BaseApiServices {

  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson;
    try {

      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    
    dynamic responseJson;
    print('url network: data: $data');
    try {
      // Menampilkan data yang akan dikirim ke server
      print("Data yang dikirim ke server: ${jsonEncode(data)}");
      
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse (http.Response response) {

    switch(response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error accured while communicaating with server' + 
          'with status code' +response.statusCode.toString());
    }
  }
}
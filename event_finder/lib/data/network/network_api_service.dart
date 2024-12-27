// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_adjacent_string_concatenation, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:event_finder/data/app_exceptions.dart';
import 'package:event_finder/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../../view_model/user_preferences.dart';

class NetworkApiService extends BaseApiServices {
  // Ambil token dari UserPreferences
  Future<String> _getToken() async {
    String? token =
        await UserPreferences.getToken(); // Ambil token dari SharedPreferences
    if (token == null || token.isEmpty) {
      token = '';
    }
    return token;
  }

  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final token = await _getToken();

      final headers = {
        'Cache-Control': 'no-cache, no-store, must-revalidate',
        'Pragma': 'no-cache',
        'Expires': '0',
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

          print('Response status: ${response.body}'); // Debug log

      // Menangani response
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      // Penanganan kesalahan umum
      throw FetchDataException('An error occurred: $e');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    // print('url network: data: $data');
    try {
      // Menampilkan data yang akan dikirim ke server
      // print("Data yang dikirim ke server: ${jsonEncode(data)}");

      String token = await _getToken();

      if (token.isEmpty || token == '') {
        Response response =
            await post(Uri.parse(url), body: jsonEncode(data), headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        }).timeout(Duration(seconds: 10));
        responseJson = returnResponse(response);
      } else {
        Response response =
            await post(Uri.parse(url), body: jsonEncode(data), headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        }).timeout(Duration(seconds: 10));
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // New method for handling multipart form data with file upload
  @override
  Future postMultipartApiResponse(String url, Map<String, dynamic> data,
      List<int> imageBytes, String fileName) async {
    // print('url network: data: $data');

    dynamic responseJson;
    try {
      String token = await _getToken();
      // print('token: $token');

      var request = http.MultipartRequest('POST', Uri.parse(url));
      // print('request: $request');

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Add file
      request.files.add(
        http.MultipartFile.fromBytes('image', imageBytes,
            filename: fileName, contentType: MediaType('image', 'png')),
      );

      // Add other fields
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Send request
      var streamedResponse =
          await request.send().timeout(Duration(seconds: 30));
      var response = await http.Response.fromStream(streamedResponse);

      print('response: $response');

      // print('response.body: ${response.body}');
      // print('request.files: ${request.files}');
      // print('request.fields: ${request.fields}');
      // print('request.headers: ${request.headers}');
      // print('request.url: ${request.url}');
      // print('request.method: ${request.method}');
      // print('request.contentLength: ${request.contentLength}');

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      // print('Error: $e');
      throw FetchDataException('Error occurred: ${e.toString()}');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, Map<String, dynamic> data,
      List<int> imageBytes, String fileName) async {
    dynamic responseJson;
    try {
      String token = await _getToken();
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.files.add(
        http.MultipartFile.fromBytes('image', imageBytes,
            filename: fileName, contentType: MediaType('image', 'png')),
      );

      // Add other fields
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Send request
      var streamedResponse =
          await request.send().timeout(Duration(seconds: 30));
      var response = await http.Response.fromStream(streamedResponse);

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('Error occurred: ${e.toString()}');
    }
    return responseJson;
  }

  // In your ApiService class
  @override
  Future getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      String token = await _getToken();

      print('Delete URL: $url'); // Debug log
      print('Token: $token'); // Debug log

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutStatusEventApiResponse(String url, String id, String status) async {
    dynamic responseJson;
    try {
      String token = await _getToken();
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Add other fields
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Send request
      var streamedResponse =
          await request.send().timeout(Duration(seconds: 30));
      var response = await http.Response.fromStream(streamedResponse);

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('Error occurred: ${e.toString()}');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
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
        throw FetchDataException(
            'Error accured while communicaating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}

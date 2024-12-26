// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:io';
import 'package:event_finder/data/app_exceptions.dart';
import 'package:event_finder/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class NetworkApiService extends BaseApiServices {
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NzYyNGQ4MGNlNzI0YTRmY2I4MjMzOGMiLCJuYW1lIjoiSm9obiBEb2UiLCJlbWFpbCI6ImpvaG5kb2FhYWVAZXhhbXBsZS5jb20iLCJpYXQiOjE3MzUxODMyOTksImV4cCI6MTczNTU0MzI5OX0.77y5a-cBDx4E3LZ-DsFGHUv8Ngp6RSmfAU29YT2R-6U';

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    print('url network: $url');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Cache-Control': 'no-cache, no-store, must-revalidate',
        'Pragma': 'no-cache',
        'Expires': '0'
      }).timeout(const Duration(seconds: 10));
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

      Response response =
          await post(Uri.parse(url), body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      }).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // New method for handling multipart form data with file upload
  @override
  Future postMultipartApiResponse(String url, Map<String, dynamic> data,
      List<int> imageBytes, String fileName) async {
    dynamic responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

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

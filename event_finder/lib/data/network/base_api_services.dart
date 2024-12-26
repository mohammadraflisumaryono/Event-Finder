abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> postMultipartApiResponse(String url,
      Map<String, dynamic> data, List<int> imageBytes, String fileName);

  // Put Request
  Future<dynamic> getPutApiResponse(String url, Map<String, dynamic> data,
      List<int> imageBytes, String fileName);

  Future<dynamic> getDeleteApiResponse(String Url);
}

// ignore_for_file: non_constant_identifier_names

import 'package:event_finder/data/network/base_api_services.dart';
import 'package:event_finder/data/network/network_api_service.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/res/component/app_url.dart';

class EventRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<EventListModel> fetchEventsList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllEventsEndPoint);
      return response = EventListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createEventApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.eventEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getTrendingEventApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllEventsEndPoint);
      return EventListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createEventWithImageApi({
    required Map<String, dynamic> eventData,
    required List<int> imageBytes,
    required String fileName,
  }) async {
    try {
      dynamic response = await _apiServices.postMultipartApiResponse(
        AppUrl.eventEndPoint,
        eventData,
        imageBytes,
        fileName,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

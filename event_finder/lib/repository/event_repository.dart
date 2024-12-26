// ignore_for_file: non_constant_identifier_names

import 'package:event_finder/data/network/base_api_services.dart';
import 'package:event_finder/data/network/network_api_service.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/res/component/app_url.dart';

class EventRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  // Ambil semua data event
  Future<EventListModel> fetchEventsList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllEventsEndPoint);

      response['data'].forEach((element) {
        element['image'] = AppUrl.ImageUrl + element['image'];
      });
      return response = EventListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Membuat data event
  Future<dynamic> createEventApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.eventEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Ambil data event berdasarkan trending/views
  Future<dynamic> getTrendingEventApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllEventsEndPoint);

      // concat response with base url AppUrl.baseUrl/uploads/images/imageName
      response['data'].forEach((element) {
        element['image'] = AppUrl.ImageUrl + element['image'];
      });

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

  // Ambil data event berdasarkan ID organizer
  Future<dynamic> getEventByOrganizerApi(String organizerId) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(AppUrl.eventByOrganizer(organizerId));
      return response = EventListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// Update data event
  Future<dynamic> updateEventWithImage({
    required Map<String, dynamic> eventData,
    required List<int> imageBytes,
    required String fileName,
    required String eventId,
  }) async {
    try {
      dynamic response = await _apiServices.postMultipartApiResponse(
        AppUrl.eventById(eventId),
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

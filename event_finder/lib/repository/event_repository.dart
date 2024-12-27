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

      return response = EventListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Membuat data event
  Future<dynamic> createEventApi(dynamic data) async {
    // print('data: $data');
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
    // print('data: $eventData');
    // print('imageBytes: $imageBytes');
    // print('fileName: $fileName');

    try {
      dynamic response = await _apiServices.postMultipartApiResponse(
        AppUrl.eventEndPoint,
        eventData,
        imageBytes,
        fileName,
      );
      // print('response $response');
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

      return EventListModel.fromJson(response);
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
      dynamic response = await _apiServices.getPutApiResponse(
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

  // Delete data event
  Future<dynamic> deleteEventApi(String id) async {
    try {
      dynamic response =
          await _apiServices.getDeleteApiResponse(AppUrl.eventById(id));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Ambil data event berdasarkan ID

  Future<Event> getEventByIdApi(String id) async {
    print('id: $id');
    print(AppUrl.eventById(id));

    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.eventById(id));

      // Assuming the response structure is like:
      // { "status": "success", "data": { event data } }
      if (response['status'] == 'success') {
        return Event.fromJson(
            response['data']); // Parsing the nested 'data' object
      } else {
        throw Exception("Failed to fetch event");
      }
    } catch (e) {
      print("Error fetching event by ID repo: $e");
      rethrow;
    }
  }
}

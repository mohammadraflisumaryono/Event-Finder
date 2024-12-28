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
      print('response: $response');
      print('response: ${EventListModel.fromJson(response)}');

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
      // print requestData without image
      print('eventData: ${eventData.toString()}');
      dynamic response = await _apiServices.getPutApiResponse(
        AppUrl.updateEvent(eventId),
        eventData,
        imageBytes,
        fileName,
      );
      print(eventId);
      return response;
    } catch (e) {
      print(e);
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
    // print('id: $id');
    // print(AppUrl.eventById(id));

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

  // Ambil data event berdasarkan status
  Future<List<Event>> getEventByStatusApi() async {
    try {
      // Kirim request API untuk mendapatkan event berdasarkan status
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.eventStatusEndPoint);

      // Print respons API untuk debug
      print('response: $response');

      // Memeriksa apakah response adalah Map<String, dynamic> (JSON)
      if (response is Map<String, dynamic>) {
        // Memeriksa apakah status adalah success
        if (response['status'] == 'success') {
          // Memeriksa apakah data adalah List
          if (response['data'] is List) {
            // Ambil data dari response['data'] (list events)
            List<dynamic> data = response['data'];

            // Proses data event menjadi list objek Event
            List<Event> eventList =
                List<Event>.from(data.map((event) => Event.fromJson(event)));

            return eventList;
          } else {
            // Jika response['data'] bukan list, lempar exception
            throw Exception("Response 'data' is not a list");
          }
        } else {
          // Jika status tidak success, lempar exception dengan pesan error
          throw Exception('Failed to fetch events: ${response['message']}');
        }
      } else {
        // Jika response bukan Map<String, dynamic>, lempar exception
        throw Exception('Response is not a valid JSON object');
      }
    } catch (e) {
      // Menangani kesalahan dan melemparkan error untuk debugging
      print('Error fetching events: $e');
      rethrow;
    }
  }

  // Fungsi untuk memperbarui status event
  Future<void> updateEventStatus(String eventId, String status) async {
    try {
      // Kirim request API untuk memperbarui status event
      dynamic response = await _apiServices.getPutStatusApiResponse(
        AppUrl.updateStatusEvent(eventId),
        {'status': status},
      );

      // Print respons API untuk debug
      print('response: $response');
    } catch (e) {
      rethrow;
    }
  }
  // Future<dynamic> updateEventWithImage({
  //   required Map<String, dynamic> eventData,
  //   required List<int> imageBytes,
  //   required String fileName,
  //   required String eventId,
  // }) async {
  //   try {
  //     dynamic response = await _apiServices.getPutApiResponse(
  //       AppUrl.eventById(eventId),
  //       eventData,
  //       imageBytes,
  //       fileName,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}

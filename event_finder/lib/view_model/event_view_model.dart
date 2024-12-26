import 'package:event_finder/data/response/api_response.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/model/event_category.dart';
import 'package:event_finder/repository/event_repository.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/status_event.dart';
import '../utils/utils.dart';

class EventViewModel with ChangeNotifier {
  final _myRepo = EventRepository();

  ApiResponse<EventListModel> eventsList = ApiResponse.loading();

  setEventList(ApiResponse<EventListModel> response) {
    eventsList = response;
    notifyListeners();
  }

  // Mengambil semua data event
  Future<void> fetchEventListApi() async {
    setEventList(ApiResponse.loading());
    try {
      final value = await _myRepo.fetchEventsList();
      setEventList(ApiResponse.completed(value));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
  }

  // Mengambil data event by category
  Future<void> fetchEventsByCategory(String category) async {
    setEventList(ApiResponse.loading());
    try {
      final value = await _myRepo.fetchEventsList();
      final filteredEvents = value.events
          ?.where((event) =>
              event.category?.value.toLowerCase() == category.toLowerCase())
          .toList();
      setEventList(
          ApiResponse.completed(EventListModel(events: filteredEvents)));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
  }

  Future<void> fetchTrendingEvents() async {
    print('Fetching trending events...');
    setEventList(ApiResponse.loading()); // Menandai state sebagai "loading"

    try {
      // Panggil API untuk mendapatkan trending events
      final EventListModel value = await _myRepo.getTrendingEventApi();

      print('Response: $value');
      // Filter event yang statusnya bukan expired
      final trendingEvents = value.events;

      print('Filtered events: $trendingEvents');

      // Update state dengan data yang berhasil diambil
      setEventList(
          ApiResponse.completed(EventListModel(events: trendingEvents)));
    } catch (error) {
      print('Error: $error');
      setEventList(
          ApiResponse.error(error.toString())); // Update state dengan error
    }
  }

  // Mengambil data event by time
  Future<void> fetchUpcomingEvents(DateTime currentDate) async {
    setEventList(ApiResponse.loading());
    try {
      final value = await _myRepo.fetchEventsList();
      final upcomingEvents = value.events
          ?.where(
              (event) => event.date != null && event.date!.isAfter(currentDate))
          .toList()
        ?..sort((a, b) => a.date!.compareTo(b.date!));
      setEventList(
          ApiResponse.completed(EventListModel(events: upcomingEvents)));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
  }

  // Fungsi untuk mengambil dan mengelompokkan event berdasarkan status
  Future<void> fetchAndCategorizeEvents(String organizerId) async {
    print('Fetching organizer events...');
    setEventList(ApiResponse.loading());
    try {
      final eventListModel = await _myRepo.getEventByOrganizerApi(organizerId);

      print('Response: $eventListModel');

      // Mengelompokkan event berdasarkan status
      final Map<StatusEvent, List<Event>> categorizedEvents = {
        StatusEvent.approved: [],
        StatusEvent.pending: [],
        StatusEvent.rejected: [],
        StatusEvent.expired: []
      };

      for (var event in eventListModel.events ?? []) {
        if (event.status != null) {
          categorizedEvents[event.status!]!.add(event);
        }
      }

      // Menyortir setiap kategori event berdasarkan tanggal
      categorizedEvents.forEach((status, events) {
        events.sort((a, b) => a.date!.compareTo(b.date!));
      });

      // Menggabungkan semua event yang telah dikelompokkan
      final allEvents = categorizedEvents.values.expand((x) => x).toList();

      setEventList(ApiResponse.completed(EventListModel(events: allEvents)));
    } catch (error) {
      print('Error: $error');
      setEventList(ApiResponse.error(error.toString()));
    }
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Fungsi untuk membuat event baru menggunakan API
  Future<void> createEventApi(dynamic data, BuildContext context) async {
    print('dataaa $data');
    setLoading(true);

    _myRepo.createEventApi(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Event Created Successfully');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> createEventWithImage({
    required Map<String, dynamic> eventData,
    required List<int> imageBytes,
    required String fileName,
    required BuildContext context,
  }) async {
    setLoading(true);

    print(eventData);

    try {
      // Menambahkan time_start dan time_end ke dalam objek time
      final eventDataWithTime = {
        ...eventData,
        'time': jsonEncode({
          'start': eventData['time_start'],
          'end': eventData['time_end'],
        }),
        // Hapus properti time_start dan time_end yang sudah digabungkan
        'time_start': null,
        'time_end': null,
      };

      print('view model data : $eventDataWithTime');

      // Mengirim data ke API dengan format yang benar
      final value = await _myRepo.createEventWithImageApi(
        eventData: eventDataWithTime,
        imageBytes: imageBytes,
        fileName: fileName,
      );

      setLoading(false);
      Utils.toastMessage('Event Created Successfully');
      Navigator.pop(context, RoutesName.adminHome);

      if (kDebugMode) {
        print('Event created successfully: ${value.toString()}');
      }
    } catch (error) {
      setLoading(false);
      Utils.toastMessage(error.toString());

      if (kDebugMode) {
        print('Error creating event: ${error.toString()}');
      }
    }
  }
}

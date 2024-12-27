import 'package:event_finder/data/response/api_response.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/model/event_category.dart';
import 'package:event_finder/repository/event_repository.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/view_model/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../model/status_event.dart';
import '../utils/utils.dart';

class EventViewModel with ChangeNotifier {
  final _myRepo = EventRepository();

  ApiResponse<EventListModel> eventsList = ApiResponse.loading();
  // State khusus untuk Latest Event
  ApiResponse<EventListModel> latestEvent = ApiResponse.loading();

  setEventList(ApiResponse<EventListModel> response) {
    eventsList = response;
    notifyListeners();
  }

  setLatestEvent(ApiResponse<EventListModel> response) {
    latestEvent = response;
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
    setEventList(ApiResponse.loading());
    try {
      final eventListModel = await _myRepo.getEventByOrganizerApi(organizerId);

      // print('Events after deletion: ${eventListModel.events}');

      // print('Response: $eventListModel');
      // print('Event list model: ${eventListModel.events}');
      // print('Total events fetched: ${eventListModel.events!.length}');

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
      // Menambahkan notifyListeners untuk memberi tahu UI
      notifyListeners(); // Ini yang ditambahkan
    } catch (error) {
      // print('Error: $error');
      setEventList(ApiResponse.error(error.toString()));

      // Menambahkan notifyListeners untuk memberi tahu UI saat terjadi error
      notifyListeners(); // Ini yang ditambahkan
    }
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> createEventWithImage({
    required Map<String, dynamic> eventData,
    required List<int> imageBytes,
    required String fileName,
    required BuildContext context,
  }) async {
    setLoading(true);

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

      // Mengirim data ke API dengan format yang benar
      final value = await _myRepo.createEventWithImageApi(
        eventData: eventDataWithTime,
        imageBytes: imageBytes,
        fileName: fileName,
      );
      // ambil user id dari shared preferences
      final organizerId = UserPreferences.getUserId().toString();

      setLoading(false);
      Utils.toastMessage('Event Created Successfully');
      Navigator.pop(context, RoutesName.adminHome);

      notifyListeners(); // Memberitahu UI untuk memperbarui

      // Setelah penghapusan, ambil ulang data events
      await fetchAndCategorizeEvents(organizerId);

      if (kDebugMode) {
        print('Event created successfully: ${value.toString()}');
      }
    } catch (error) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    }
  }

  Future<String> updateEventWithImage({
    required Map<String, dynamic> eventData,
    required List<int> imageBytes,
    required String fileName,
    required BuildContext context,
    required String eventId,
  }) async {
    print('update event view model');
    print('Updating event with ID: $eventId');
    print('Event data: $eventData');

    setLoading(true);

    try {
      // Menambahkan time_start dan time_end ke dalam objek time
      final eventDataWithTime = {
        ...eventData,
        'time': jsonEncode({
          'start': eventData['time_start'],
          'end': eventData['time_end'],
        }),
        'time_start': null,
        'time_end': null,
      };

      // Mengirim data ke API dengan format yang benar
      final value = await _myRepo.updateEventWithImage(
        eventData: eventDataWithTime,
        imageBytes: imageBytes,
        fileName: fileName,
        eventId: eventId,
      );

      setLoading(false);
      Utils.toastMessage('Event Updated Successfully');
      Navigator.pop(context, RoutesName.adminHome);

      if (kDebugMode) {
        print('Event updated successfully: ${value.toString()}');
      }

      // Return a success message or the updated data
      return 'Event updated successfully';
    } catch (error) {
      setLoading(false);
      Utils.toastMessage(error.toString());

      if (kDebugMode) {
        print('Error updating event: ${error.toString()}');
      }

      return 'Error updating event';
    }
  }

  // get latest event
  Future<void> getLatestEvents() async {
    setLatestEvent(ApiResponse.loading());
    try {
      final value = await _myRepo.fetchEventsList();
      // Ambil maksimal 6 event pertama dari daftar
      final latestEvents = value.events?.take(6).toList();

      if (latestEvents != null && latestEvents.isNotEmpty) {
        setLatestEvent(
          ApiResponse.completed(EventListModel(events: latestEvents)),
        );
      } else {
        setLatestEvent(ApiResponse.error("No events found"));
      }
    } catch (error) {
      setLatestEvent(ApiResponse.error(error.toString()));
    }
  }

  Future<void> fetchSearchAndCategory({
    String? query,
    String? category,
  }) async {
    setEventList(ApiResponse.loading());
    try {
      final value = await _myRepo.fetchEventsList();

      // Filter berdasarkan query dan/atau kategori
      final filteredEvents = value.events?.where((event) {
        final matchesQuery = query == null ||
            event.title?.toLowerCase().contains(query.toLowerCase()) == true;
        final matchesCategory = category == null ||
            event.category?.value.toLowerCase() == category.toLowerCase();
        return matchesQuery && matchesCategory;
      }).toList();

      setEventList(
          ApiResponse.completed(EventListModel(events: filteredEvents)));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
  }

  Future<void> deleteEventById(
      {required String id,
      required String organizerId,
      required BuildContext context}) async {
    setLoading(true);

    try {
      print('Attempting to delete event with ID: $id'); // Debug log

      await _myRepo.deleteEventApi(id); // Panggil API delete event

      // Update state untuk menghapus event dari daftar lokal (eventsList)
      eventsList.data!.events?.removeWhere((event) => event.id == id);
      notifyListeners(); // Memberitahu UI untuk memperbarui

      // Setelah penghapusan, ambil ulang data events
      await fetchAndCategorizeEvents(organizerId);

      // Jika event berhasil dihapus, tampilkan pesan sukses dan update UI
      Utils.toastMessage('Event Deleted Successfully');

      Navigator.pop(context); // Menutup dialog atau navigasi
    } catch (error) {
      setLoading(false); // Menandakan proses selesai meskipun gagal
      Utils.toastMessage(error.toString());
    } finally {
      setLoading(false); // Menyelesaikan loading
    }
  }

  Future<void> fetchEventById(String id) async {
    print('Fetching event with ID: $id');
    setEventList(ApiResponse.loading());
    try {
      print('Fetching event with ID: $id');
      final value = await _myRepo.getEventByIdApi(id);
      print('Event fetched: $value');
      setEventList(ApiResponse.completed(value));
    } catch (error) {
      print('Error fetching event: $error');
      setEventList(ApiResponse.error(error.toString()));
    }
  }
}

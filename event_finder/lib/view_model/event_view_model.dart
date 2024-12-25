
import 'package:event_finder/data/response/api_response.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/model/event_category.dart';
import 'package:event_finder/repository/event_repository.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class EventViewModel with  ChangeNotifier {
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
          ?.where((event) => event.category?.value.toLowerCase() == category.toLowerCase())
          .toList();
      setEventList(ApiResponse.completed(EventListModel(events: filteredEvents)));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
  }

  // Mengambil data event berdasarkan trending
  Future<void> fetchTrendingEvents() async {
    print('api hit');
    setEventList(ApiResponse.loading());
    try {
      
      // Panggil API untuk mendapatkan event trending berdasarkan views
      final value = await _myRepo
          .getTrendingEventApi(); // Memanggil API untuk mendapatkan data event
      final trendingEvents = value.events
          ?.where((event) =>
              event.status !=
              'expired') // Filter event yang statusnya bukan expired
          .toList();

      setEventList(
          ApiResponse.completed(EventListModel(events: trendingEvents)));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
  }


  // Mengambil data event by time
  Future<void> fetchUpcomingEvents(DateTime currentDate) async {
  setEventList(ApiResponse.loading());
  try {
    final value = await _myRepo.fetchEventsList();
    final upcomingEvents = value.events
        ?.where((event) => event.date != null && event.date!.isAfter(currentDate))
        .toList()
      ?..sort((a, b) => a.date!.compareTo(b.date!));
    setEventList(ApiResponse.completed(EventListModel(events: upcomingEvents)));
  } catch (error) {
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
    setLoading(true);

    _myRepo.createEventApi(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Event Created Successfully');
      Navigator.pop(context, RoutesName.adminHome); // Kembali ke halaman sebelumnya
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

  // Future<void> fetchEventListApi() async {

  //   setEventList(ApiResponse.loading());

  //   _myRepo.fetchEventsList().then((value){

  //     setEventList(ApiResponse.completed(value));

  //   }).onError((error, StackTrace) {

  //     setEventList(ApiResponse.error(error.toString()));

  //   });
  // } 

 }
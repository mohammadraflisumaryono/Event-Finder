
import 'package:event_finder/data/response/api_response.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/repository/event_repository.dart';
import 'package:flutter/foundation.dart';

class EventViewModel with  ChangeNotifier {
  final _myRepo = EventRepository();

  ApiResponse<EventListModel> eventsList = ApiResponse.loading();

  setEventList(ApiResponse<EventListModel> response) {
    eventsList = response;
    notifyListeners();
  }

  // Menggunakan async/await untuk menangani pemanggilan API
  Future<void> fetchEventListApi() async {
    setEventList(ApiResponse.loading());
    try {
      final value = await _myRepo.fetchEventsList();
      setEventList(ApiResponse.completed(value));
    } catch (error) {
      setEventList(ApiResponse.error(error.toString()));
    }
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
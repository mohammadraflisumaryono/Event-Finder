// ignore_for_file: non_constant_identifier_names

import 'package:event_finder/data/network/base_api_services.dart';
import 'package:event_finder/data/network/network_api_service.dart';
import 'package:event_finder/model/events_model.dart';
import 'package:event_finder/res/component/app_url.dart';

class EventRepository {

  final BaseApiServices _apiServices = NetworkApiService();

  Future<EventListModel> fetchEventsList() async {
    // return await _apiServices.getGetApiResponse(AppUrl.getAllEventsEndPoint);
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getAllEventsEndPoint);
      return response = EventListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  
}
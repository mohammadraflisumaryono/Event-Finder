
// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {

  static var baseUrl = 'https://event-finder-production.up.railway.app/api/';

  static var loginEndPoint = baseUrl + 'login';

  static var registerEndPoint = baseUrl + 'register';

  static var eventEndPoint = baseUrl + 'events';

  static var getAllEventsEndPoint = baseUrl + 'events';

  static String eventByCategory(String category) {
    return '${baseUrl}events/category/$category';
  }
}
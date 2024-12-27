// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  static var baseUrl = 'https://event-finder-production.up.railway.app/api/';
  // static var baseUrl = 'http://localhost:3000/api/';

  static var loginEndPoint = baseUrl + 'login';

  static var registerEndPoint = baseUrl + 'register';

  static var eventEndPoint = baseUrl + 'events';

  static var getAllEventsEndPoint = baseUrl + 'events';

  static var trendingEndPoint = baseUrl + 'trending';

  static String eventByCategory(String category) {
    return '${baseUrl}events/category/$category';
  }

  static String eventById(String id) {
    return '${baseUrl}events/$id';
  }

  static String eventByOrganizer(String id) {
    return '${baseUrl}events/organizer/$id';
  }
}

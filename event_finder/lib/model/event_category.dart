enum EventCategory {
  concert,
  seminar,
  workshop,
  festival,
  conference,
  other
}

extension EventCategoryExtension on EventCategory {
  String get value {
    switch (this) {
      case EventCategory.concert:
        return 'Concert';
      case EventCategory.seminar:
        return 'Seminar';
      case EventCategory.workshop:
        return 'Workshop';
      case EventCategory.festival:
        return 'Festival';
      case EventCategory.conference:
        return 'Conference';
      case EventCategory.other:
        return 'Other';
      default:
        return '';
    }
  }

  // Mengonversi string menjadi enum
  static EventCategory fromString(String category) {
    switch (category.toLowerCase()) {
      case 'concert':
        return EventCategory.concert;
      case 'seminar':
        return EventCategory.seminar;
      case 'workshop':
        return EventCategory.workshop;
      case 'festival':
        return EventCategory.festival;
      case 'conference':
        return EventCategory.conference;
      case 'other':
        return EventCategory.other;
      default:
        throw Exception('Invalid category');
    }
  }
}

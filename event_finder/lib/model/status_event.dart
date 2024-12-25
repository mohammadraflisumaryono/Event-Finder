enum StatusEvent { pending, approved, rejected, expired }

extension StatusEventExtension on StatusEvent {
  String get value {
    switch (this) {
      case StatusEvent.pending:
        return 'Pending';
      case StatusEvent.approved:
        return 'Approved';
      case StatusEvent.rejected:
        return 'Rejected';
      case StatusEvent.expired:
        return 'Expired';
      default:
        return '';
    }
  }

  // Mengonversi string menjadi enum
  static StatusEvent fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return StatusEvent.pending;
      case 'approved':
        return StatusEvent.approved;
      case 'rejected':
        return StatusEvent.rejected;
      case 'expired':
        return StatusEvent.expired;
      default:
        throw Exception('Invalid status');
    }
  }
}

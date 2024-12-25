
// ignore_for_file: unnecessary_this

import 'package:event_finder/model/event_category.dart';
import 'package:event_finder/model/event_time.dart';
import 'package:event_finder/model/status_event.dart';

class EventListModel {
  List<Event>? events;

  EventListModel({this.events});

  EventListModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Event>[];
      json['events'].forEach((v) {
        events!.add(Event.fromJson(v));  // Memastikan Event.fromJson dipanggil dengan benar
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  String? id;
  String? title;
  DateTime? date;
  EventTime? time;  // Menggunakan EventTime untuk menangani start dan end
  String? location;
  String? description;
  String? image;
  EventCategory? category;  // Menggunakan EventCategory enum
  double? ticketPrice;
  String? registrationLink;
  StatusEvent? status;
  int? views;

  Event ({
    this.id,
    this.title,
    this.date,
    this.time,
    this.location,
    this.description,
    this.image,
    this.category,
    this.ticketPrice,
    this.registrationLink,
    this.status,
    this.views
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      time: json['time'] != null ? EventTime.fromJson(json['time']) : null, // Mengonversi time
      location: json['location'],
      description: json['description'],
      image: json['image'],
      category: json['category'] != null ? EventCategoryExtension.fromString(json['category']) : null, // Mengonversi string ke enum
      ticketPrice: json['ticket_price']?.toDouble(),
      registrationLink: json['registration_link'],
      status: json['status'] != null
          ? StatusEventExtension.fromString(json['status'])
          : null,
      views: json['views']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'date': date?.toIso8601String(),
      'time': time?.toJson(),
      'location': location,
      'description': description,
      'image': image,
      'category': category?.value,  // Menggunakan EventCategoryExtension untuk mengambil value string
      'ticket_price': ticketPrice,
      'registration_link': registrationLink,
      'status': status,
      'views': views
    };
  }
}


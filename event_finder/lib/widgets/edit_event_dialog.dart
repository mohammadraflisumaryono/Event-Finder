// ignore_for_file: prefer_const_constructors

import 'package:event_finder/view_model/event_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:event_finder/model/event_category.dart';
import 'package:provider/provider.dart';

class EditEventDialog extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const EditEventDialog({Key? key, this.initialData}) : super(key: key);

  @override
  _EditEventDialogState createState() => _EditEventDialogState();
}

class _EditEventDialogState extends State<EditEventDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _location;
  String? _description;
  Uint8List? _image;
  EventCategory? _category;
  double? _ticketPrice;
  String? _registrationLink;
  String? _imageFileName;
  String? _eventId;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      final data = widget.initialData!;
      _title = data['title'];
      _date = DateTime.tryParse(data['date']);
      _startTime = data['time_start'] != null
          ? TimeOfDay.fromDateTime(DateTime.parse(data['time_start']))
          : null;
      _endTime = data['time_end'] != null
          ? TimeOfDay.fromDateTime(DateTime.parse(data['time_end']))
          : null;
      _location = data['location'];
      _description = data['description'];
      _category = EventCategory.values.firstWhere(
          (e) => e.value == data['category'],
          orElse: () => EventCategory.other);
      _ticketPrice = double.tryParse(data['ticket_price'] ?? '0');
      _registrationLink = data['registration_link'];
      _eventId = data['event_id']; // Pastikan ID event ada di data
    }
  }

  // get initial data event id
  // void getEventId() {
  //
  // }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? _startTime ?? TimeOfDay.now()
          : _endTime ?? TimeOfDay.now(),
    );
    if (picked != null)
      setState(() => isStartTime ? _startTime = picked : _endTime = picked);
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _image = result.files.single.bytes;
        _imageFileName = result.files.single.name;
      });
    }
  }

  DateTime convertTimeOfDayToDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
    return AlertDialog(
      title: Text('Edit Event'),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(labelText: 'Event Title'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                  onSaved: (value) => _title = value,
                ),
                ListTile(
                  title: Text(_date == null
                      ? 'Select Date'
                      : DateFormat('yyyy-MM-dd').format(_date!)),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
                ListTile(
                  title: Text(_startTime == null
                      ? 'Select Start Time'
                      : _startTime!.format(context)),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, true),
                ),
                ListTile(
                  title: Text(_endTime == null
                      ? 'Select End Time'
                      : _endTime!.format(context)),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectTime(context, false),
                ),
                TextFormField(
                  initialValue: _location,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a location' : null,
                  onSaved: (value) => _location = value,
                ),
                TextFormField(
                  initialValue: _description,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onSaved: (value) => _description = value,
                ),
                ListTile(
                  title: Text(_imageFileName ?? 'No Image Selected'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.file_upload),
                        onPressed: _pickFile,
                      ),
                      if (_image != null)
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => setState(() {
                            _image = null;
                            _imageFileName = null;
                          }),
                        ),
                    ],
                  ),
                ),
                DropdownButtonFormField<EventCategory>(
                  value: _category,
                  decoration: InputDecoration(labelText: 'Category'),
                  items: EventCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.value),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _category = value),
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                  hint: Text('Select Category'),
                ),
                TextFormField(
                  initialValue: _ticketPrice?.toString(),
                  decoration: InputDecoration(labelText: 'Ticket Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter a ticket price';
                    final parsed = double.tryParse(value);
                    if (parsed == null) return 'Please enter a valid number';
                    return null;
                  },
                  onSaved: (value) => _ticketPrice = double.tryParse(value!),
                ),
                TextFormField(
                  initialValue: _registrationLink,
                  decoration: InputDecoration(labelText: 'Registration Link'),
                  onSaved: (value) => _registrationLink = value,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (_date == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a date')),
                );
                return;
              }
              if (_startTime == null || _endTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Please select both start and end times')),
                );
                return;
              }
              if (convertTimeOfDayToDateTime(_date!, _startTime!)
                  .isAfter(convertTimeOfDayToDateTime(_date!, _endTime!))) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Start time must be before end time')),
                );
                return;
              }
              // Save form data
              _formKey.currentState!.save();

              // Persiapkan data untuk dikirim ke API
              final eventData = {
                'title': _title,
                'date': _date!.toIso8601String(),
                'time_start': convertTimeOfDayToDateTime(_date!, _startTime!)
                    .toIso8601String(),
                'time_end': convertTimeOfDayToDateTime(_date!, _endTime!)
                    .toIso8601String(),
                'location': _location,
                'description': _description,
                'category': _category!.value,
                'ticket_price': _ticketPrice.toString(),
                'registration_link': _registrationLink,
                'image': _image,
                'file_name': _imageFileName,
              };
              // get event id

              // Memanggil method untuk update event
              try {
                if (widget.initialData != null) {
                  final data = widget.initialData!;
                  _eventId = data['event_id'];
                }

                print('updating event..., $_imageFileName, $_eventId');
                final response = await eventViewModel.updateEventWithImage(
                  eventData: eventData,
                  imageBytes: _image!, // Gunakan _image sebagai bytes
                  fileName: _imageFileName ??
                      '', // Default to an empty string if null
                  eventId: _eventId!,
                  context: context,
                );

                print('response: $response');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response)), // Use the returned message
                );

                Navigator.pop(context, response);
              } catch (error) {
                print('error: $error');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating event: $error')),
                );
              }
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

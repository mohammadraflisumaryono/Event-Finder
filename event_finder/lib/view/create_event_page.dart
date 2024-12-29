// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/view_model/event_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:event_finder/model/event_category.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
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

  DateTime convertTimeOfDayToDateTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String? _imageFileName; // Tambahkan variable untuk nama file

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final bytes = result.files.single.bytes;

      if (bytes != null) {
        setState(() {
          _image = bytes;
          _imageFileName = result.files.single.name; // Simpan nama file
        });
      } else {
        print('File bytes are null');
      }
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Event',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'lib/res/assets/images/logogoova.png',
              width: 40, // Ganti dengan ukuran logo sesuai kebutuhan
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Title',
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                  onSaved: (value) => _title = value,
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text(_date == null
                      ? 'Select Date'
                      : DateFormat('yyyy-MM-dd').format(_date!)),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a location' : null,
                  onSaved: (value) => _location = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onSaved: (value) => _description = value,
                ),
                SizedBox(height: 16),
                Text(
                  "Event Image :",
                  style: TextStyle(fontSize: 16),
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        _image == null ? 'No Image Selected' : 'Image Selected',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.file_upload),
                        onPressed: _pickFile,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<EventCategory>(
                  decoration: InputDecoration(labelText: 'Category'),
                  items: EventCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ticket Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a ticket price';
                    }
                    final parsedValue = double.tryParse(value);
                    if (parsedValue == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) => _ticketPrice = double.tryParse(value!),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Registration Link'),
                  onSaved: (value) => _registrationLink = value,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (_image == null) {
                      Utils.toastMessage('Please select an image file');
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      var eventViewModel =
                          Provider.of<EventViewModel>(context, listen: false);

                      DateTime startDateTime =
                          convertTimeOfDayToDateTime(_date!, _startTime!);
                      DateTime endDateTime =
                          convertTimeOfDayToDateTime(_date!, _endTime!);

                      Map<String, dynamic> eventData = {
                        'title': _title,
                        'date': _date!.toIso8601String(),
                        'time_start': startDateTime.toIso8601String(),
                        'time_end': endDateTime.toIso8601String(),
                        'location': _location,
                        'description': _description,
                        'category': _category!.value,
                        'ticket_price': _ticketPrice.toString(),
                        'registration_link': _registrationLink,
                      };

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text('Creating Event...'),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      try {
                        await eventViewModel.createEventWithImage(
                          eventData: eventData,
                          imageBytes: _image!,
                          fileName: _imageFileName ?? 'image.jpg',
                          context: context,
                        );

                        Navigator.of(context).pop();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Create Success"),
                              content: const Text(
                                  "Your event is created and awaiting approval by Superadmin."),
                              contentPadding: const EdgeInsets.all(16.0),
                              actionsPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, RoutesName.adminHome),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (error) {
                        Navigator.of(context).pop();
                        print(error.toString());
                      }
                    } else {
                      Utils.toastMessage('Please fill all fields correctly');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  child: Text(
                    'Create Event',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

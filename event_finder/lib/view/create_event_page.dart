// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:event_finder/model/event_category.dart';


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
  String? _image;
  EventCategory? _category;
  double? _ticketPrice;
  String? _registrationLink;

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
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Hanya mengizinkan file gambar
    );

    if (result != null) {
      setState(() {
        _image = result.files.single.path;
      });
    }
  }

  void _submitForm() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image file")),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Image path: $_image');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Your event is created and awaiting approval by superadmin.'),
          duration: Duration(seconds: 3),
        ),
      );

      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.adminHome);
      });
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
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Title',
                  hoverColor: const Color(0xFFF4F1F4),
                  fillColor: const Color.fromARGB(255, 241, 240, 241),
                  filled: true, // Aktifkan warna isi
                  border: OutlineInputBorder(),
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
              Text("Event Image : "),
              Column(
                children: [
                  ListTile(
                    title: Text(_image == null
                        ? 'No Image Selected'
                        : 'Image Selected'),
                    trailing: IconButton(
                      icon: Icon(Icons.file_upload),
                      onPressed: _pickFile,
                    ),
                  ),
                  if (_image != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(_image!), // Menampilkan gambar berdasarkan path
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
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
                  FilteringTextInputFormatter
                      .digitsOnly, // Membatasi hanya angka
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ticket price';
                  }
                  // Menambahkan validasi jika input tidak bisa diparsing menjadi angka
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
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.purple,
                ),
                child: Text(
                  'Create Event', // Tulisan pada button
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

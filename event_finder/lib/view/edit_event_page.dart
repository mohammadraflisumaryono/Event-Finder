// import 'package:event_finder/utils/routes/routes_name.dart';
// import 'package:event_finder/view_model/event_view_model.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:event_finder/model/event_category.dart';
// import 'package:provider/provider.dart';
// import 'package:event_finder/model/events_model.dart';

// class EditEventPage extends StatefulWidget {
//   final Event event;

//   EditEventPage({required this.event}); // Accept the event as a parameter

//   @override
//   _EditEventPageState createState() => _EditEventPageState();
// }

// class _EditEventPageState extends State<EditEventPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? _title;
//   DateTime? _date;
//   TimeOfDay? _startTime;
//   TimeOfDay? _endTime;
//   String? _location;
//   String? _description;
//   Uint8List? _image;
//   EventCategory? _category;
//   double? _ticketPrice;
//   String? _registrationLink;

//   DateTime convertTimeOfDayToDateTime(DateTime date, TimeOfDay time) {
//     return DateTime(
//       date.year,
//       date.month,
//       date.day,
//       time.hour,
//       time.minute,
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _date ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != _date) {
//       setState(() {
//         _date = picked;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartTime) {
//           _startTime = picked;
//         } else {
//           _endTime = picked;
//         }
//       });
//     }
//   }

//   String? _imageFileName; // Store the file name

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       withData: true,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       final bytes = result.files.single.bytes;

//       if (bytes != null) {
//         setState(() {
//           _image = bytes;
//           _imageFileName = result.files.single.name; // Store the file name
//         });
//       } else {
//         print('File bytes are null');
//       }
//     } else {
//       print('No file selected');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Initialize fields with the existing event data
//     _title = widget.event.title;
//     _date = widget.event.date;
//     _startTime = TimeOfDay.fromDateTime(widget.event.time!.start);
//     _endTime = TimeOfDay.fromDateTime(widget.event.time!.end);
//     _location = widget.event.location;
//     _description = widget.event.description;
//     _ticketPrice = widget.event.ticketPrice;
//     _registrationLink = widget.event.registrationLink;
//     _category = widget.event.category;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Edit Event',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 initialValue: _title,
//                 decoration: InputDecoration(labelText: 'Event Title'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a title' : null,
//                 onSaved: (value) => _title = value,
//               ),
//               SizedBox(height: 16),
//               ListTile(
//                 title: Text(_date == null
//                     ? 'Select Date'
//                     : DateFormat('yyyy-MM-dd').format(_date!)),
//                 trailing: Icon(Icons.calendar_today),
//                 onTap: () => _selectDate(context),
//               ),
//               SizedBox(height: 16),
//               ListTile(
//                 title: Text(_startTime == null
//                     ? 'Select Start Time'
//                     : _startTime!.format(context)),
//                 trailing: Icon(Icons.access_time),
//                 onTap: () => _selectTime(context, true),
//               ),
//               ListTile(
//                 title: Text(_endTime == null
//                     ? 'Select End Time'
//                     : _endTime!.format(context)),
//                 trailing: Icon(Icons.access_time),
//                 onTap: () => _selectTime(context, false),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _location,
//                 decoration: InputDecoration(labelText: 'Location'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter a location' : null,
//                 onSaved: (value) => _location = value,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _description,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//                 onSaved: (value) => _description = value,
//               ),
//               SizedBox(height: 16),
//               Text("Event Image:", style: TextStyle(fontSize: 16)),
//               Column(
//                 children: [
//                   ListTile(
//                     title: Text(
//                       _image == null ? 'No Image Selected' : 'Image Selected',
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.file_upload),
//                       onPressed: _pickFile,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               DropdownButtonFormField<EventCategory>(
//                 value: _category,
//                 decoration: InputDecoration(labelText: 'Category'),
//                 items: EventCategory.values
//                     .map((category) => DropdownMenuItem(
//                           value: category,
//                           child: Text(category.value),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _category = value;
//                   });
//                 },
//                 validator: (value) =>
//                     value == null ? 'Please select a category' : null,
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _ticketPrice?.toString(),
//                 decoration: InputDecoration(labelText: 'Ticket Price'),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a ticket price';
//                   }
//                   final parsedValue = double.tryParse(value);
//                   if (parsedValue == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _ticketPrice = double.tryParse(value!),
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _registrationLink,
//                 decoration: InputDecoration(labelText: 'Registration Link'),
//                 onSaved: (value) => _registrationLink = value,
//               ),
//               SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_image == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Please select an image file")),
//                     );
//                     return;
//                   }

//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();

//                     var eventViewModel =
//                         Provider.of<EventViewModel>(context, listen: false);

//                     DateTime startDateTime =
//                         convertTimeOfDayToDateTime(_date!, _startTime!);
//                     DateTime endDateTime =
//                         convertTimeOfDayToDateTime(_date!, _endTime!);

//                     Map<String, dynamic> eventData = {
//                       'title': _title,
//                       'date': _date!.toIso8601String(),
//                       'time_start': startDateTime.toIso8601String(),
//                       'time_end': endDateTime.toIso8601String(),
//                       'location': _location,
//                       'description': _description,
//                       'category': _category!.value,
//                       'ticket_price': _ticketPrice.toString(),
//                       'registration_link': _registrationLink,
//                     };

//                     try {
//                       await eventViewModel.updateEventWithImage(
//                         eventId: widget.event.id!,
//                         eventData: eventData,
//                         imageBytes: _image!,
//                         fileName: _imageFileName ?? 'image.jpg',
//                         context: context,
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Event Updated Successfully!'),
//                           duration: Duration(seconds: 3),
//                         ),
//                       );

//                       Navigator.pop(context); // Go back after saving
//                     } catch (error) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                               'Failed to update event: ${error.toString()}'),
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   backgroundColor: Colors.purple,
//                 ),
//                 child: Text(
//                   'Save Changes',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

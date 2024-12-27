
// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/events_model.dart';
// import '../model/status_event.dart';
// import '../view_model/auth_view_model.dart';
// import '../view_model/event_view_model.dart';

// class EventCardOrganizer extends StatelessWidget {
//   final bool isOrganizer;
//   final Event event; 

//   EventCardOrganizer({required this.isOrganizer, required this.event});

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewModel>(context);
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               event.title ?? 'No Title',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               event.description ?? 'No Description',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               event.date?.toIso8601String() ?? 'No Date',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey,
//               ),
//             ),
//             // Menampilkan tombol Edit dan Delete hanya jika status event adalah pending
//             if (isOrganizer && event.status == StatusEvent.pending) ...[
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) => EditEventDialog(event: event),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Edit',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: 
//                     event.id == null
//                         ? null // Disable button if ID is null
//                         : () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Confirm Delete'),
//                                   content: Text(
//                                       'Are you sure you want to delete this event?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       child: Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.pop(context); // Close dialog
//                                         Provider.of<EventViewModel>(context,
//                                                 listen: false)
//                                             .deleteEventById(
//                                           id: event.id!,
//                                           context: context,
//                                         );
//                                       },
//                                       style: TextButton.styleFrom(
//                                         foregroundColor: Colors.red,
//                                       ),
//                                       child: Text('Delete'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Delete',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EditEventDialog extends StatelessWidget {
//   final Event event; // Menerima event yang akan diedit

//   EditEventDialog({required this.event}); // Constructor untuk menerima event

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Edit Event'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Event Name TextField, diisi dengan nama event saat ini
//             TextField(
//               controller: TextEditingController(
//                   text: event.title), // Menampilkan nama event yang ada
//               decoration: InputDecoration(
//                 labelText: 'Event Name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             // Event Description TextField, diisi dengan deskripsi event saat ini
//             TextField(
//               controller: TextEditingController(
//                   text: event
//                       .description), // Menampilkan deskripsi event yang ada
//               decoration: InputDecoration(
//                 labelText: 'Event Description',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 16),
//             // Ticket Price TextField, diisi dengan harga tiket event saat ini
//             TextField(
//               controller: TextEditingController(
//                   text: event.ticketPrice
//                       ?.toString()), // Menampilkan harga tiket yang ada
//               decoration: InputDecoration(
//                 labelText: 'Ticket Price',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Logika untuk menyimpan perubahan
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Event Updated')),
//             );
//           },
//           child: Text('Save'),
//         ),
//       ],
//     );
//   }
// }

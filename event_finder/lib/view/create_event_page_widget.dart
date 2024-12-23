import 'package:flutter/material.dart';
import 'package:event_finder/view_model/create_event_page_model.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _model = CreateEventModel(
    title: '',
    description: '',
    ticketPrice: 0.0,
    startTime: DateTime.now(),
    endTime: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _model.title = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _model.description = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? 'Description is required'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ticket Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _model.ticketPrice = double.tryParse(value ?? '0.0') ?? 0.0,
                validator: (value) =>
                    (value == null || double.tryParse(value) == null)
                        ? 'Enter a valid price'
                        : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Start Time'),
                trailing: Text(
                  '${_model.startTime.hour}:${_model.startTime.minute}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_model.startTime),
                  );
                  if (time != null) {
                    setState(() {
                      _model.startTime = DateTime(
                        _model.startTime.year,
                        _model.startTime.month,
                        _model.startTime.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('End Time'),
                trailing: Text(
                  '${_model.endTime.hour}:${_model.endTime.minute}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_model.endTime),
                  );
                  if (time != null) {
                    setState(() {
                      _model.endTime = DateTime(
                        _model.endTime.year,
                        _model.endTime.month,
                        _model.endTime.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Event Created Successfully!')),
                    );
                  }
                },
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

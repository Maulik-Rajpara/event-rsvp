import 'package:event_rsvp/core/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../viewmodels/event_viewmodel.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _attendeesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),

            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: "Event Date (YYYY-MM-DD)",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,  // Disable direct text input
              onTap: () async{
                // Open the date picker when tapped
                dynamic selectedDate = await AppCommon.selectDate(context);
                if (selectedDate != null) {
                  setState(() {
                    _dateController.text = selectedDate.toLocal()
                        .toString().split(' ')[0]; // Format as yyyy-MM-dd
                  });
                }
              },
            ),
            TextField(
              controller: _attendeesController,
              decoration: InputDecoration(labelText: 'Attendee Count'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text;
                DateTime date = DateTime.tryParse(_dateController.text) ?? DateTime.now();
                int attendeeCount = int.tryParse(_attendeesController.text) ?? 0;

                if (title.isNotEmpty) {
                  // Create the new event
                  Event newEvent = Event(
                    id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
                    title: title,
                    date: date,
                    attendeeCount: attendeeCount,
                  );

                  // Save the event using the ViewModel
                  Provider.of<EventViewModel>(context, listen: false).addEvent(newEvent);

                  // Pop back to the event list screen
                  Navigator.pop(context);
                }
              },
              child: Text("Add Event"),
            ),
          ],
        ),
      ),
    );
  }



}

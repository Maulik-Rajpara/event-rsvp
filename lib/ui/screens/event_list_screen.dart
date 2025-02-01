import 'package:event_rsvp/core/utils/app_common.dart';
import 'package:event_rsvp/ui/screens/rsvp_screen.dart';
import 'package:event_rsvp/ui/screens/add_event_screen.dart'; // Import the new screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../viewmodels/event_viewmodel.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  void initState() {
    super.initState();
    // Load events when the screen is initialized

    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Events")),
      body: Consumer<EventViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.events.isEmpty) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
          }
          return ListView.builder(
            itemCount: viewModel.events.length,
            itemBuilder: (context, index) {
              Event event = viewModel.events[index];
              return ListTile(
                title: Text(event.title),
                subtitle: Text(AppCommon.formatDate(event.date)),
                trailing: Text('${event.attendeeCount} attendees'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RSVPScreen(event: event),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Event screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Event',
      ),
    );
  }

  void initData() async{
    await Future.delayed(Duration( seconds: 1));
    Provider.of<EventViewModel>(context, listen: false).loadEvents();
  }
}

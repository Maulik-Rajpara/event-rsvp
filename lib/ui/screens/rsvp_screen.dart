import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../models/rsvp.dart';
import '../viewmodels/event_viewmodel.dart';

class RSVPScreen extends StatelessWidget {
  final Event event;

  RSVPScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RSVP for ${event.title}')),
      body: Consumer<EventViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Name : ${event.title} "),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    ElevatedButton(
                      onPressed: () {
                        final rsvp = RSVP(eventId: event.id, isAttending: true);
                        viewModel.updateRSVP(rsvp);
                      },
                      child: Text('RSVP Yes'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final rsvp = RSVP(eventId: event.id, isAttending: false);
                        viewModel.updateRSVP(rsvp);
                      },
                      child: Text('Cancel RSVP'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

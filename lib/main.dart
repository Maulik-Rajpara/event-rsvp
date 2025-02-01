import 'package:event_rsvp/ui/screens/event_list_screen.dart';

import 'package:event_rsvp/ui/viewmodels/event_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/services/firebase_service.dart';
import 'core/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('events');
  await Hive.openBox('rsvps');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseService()),
        Provider(create: (_) => HiveService()),
        ChangeNotifierProvider(
            create: (context) => EventViewModel(
                firebaseService: FirebaseService(),
                hiveService: HiveService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event RSVP',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: EventListScreen(),
      ),
    );
  }
}

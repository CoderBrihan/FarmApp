import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Track(),
    );
  }
}

class Track extends StatefulWidget {
  const Track({super.key});

  @override
  State<Track> createState() => _Track();
}

class _Track extends State<Track> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
    InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification',
          'instant',
          channelDescription: 'Instant notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title:Text("Tracker",style:TextStyle(fontWeight:FontWeight.bold,fontSize:25),),backgroundColor:Colors.green,),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showNotification(
                  id: 0,
                  title: "Hello User",
                  body: "This is a test notification",
                );
              },
              child: const Text("Show Notification"),
            ),
            const SizedBox(height:20,),
            ElevatedButton(onPressed:() async{

            }, child:const Text("Set Time"))
          ],
        ),

      ),
    );
  }
}

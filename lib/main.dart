/*

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showImagePickerBottomSheet(context);
          },
          child: Text('Choose Image'),
        ),
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.26,
      maxHeight: 1,
      bottomSheetColor: Colors.white,
      context: context,
      builder: (BuildContext context, ScrollController scrollController, double offset) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Choose an Option",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (image != null) {
                        Navigator.pop(context); // Close the bottom sheet
                        // Add your image handling logic here
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.photo_camera,
                          size: 64,
                          color: Colors.grey,
                        ),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        Navigator.pop(context); // Close the bottom sheet
                        // Add your image handling logic here
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.photo_size_select_actual_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        Navigator.pop(context); // Close the bottom sheet
                        // Add your image handling logic here
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.add_to_drive_rounded,
                          size: 64,
                          color: Colors.grey,
                        ),
                        Text('Drive'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(),
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel"))
              // Add Google Drive option and functionality here.
            ],
          ),
        );
      },
    );
  }
}
*/


import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NotificationService.dart';
import 'Screen/Donor/Donor_profile.dart';
import 'Screen/splash_screen.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up: ${message.messageId}');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );// Initialize Firebase
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProfileProvider()),
    ],
    child: MyApp(),
  ),);
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService().requestNotificationPermission();
    var token = NotificationService().getDeviceToken();
    print(token.toString());
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> list;
      if (prefs.getStringList("notification_data") != null) {
        list = prefs.getStringList("notification_data")!;
      } else {
        list = [];
      }
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      String date = DateTime.now().toString();
      if (notification != null && android != null) {
        list.add(json.encode({
          'notification_hascode': notification.hashCode,
          'notification_title': notification.title,
          'notification_body': notification.body,
          'notification_time': date,
        }));
        prefs.setStringList("notification_data", list);
        print(list);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('A new message open app event was published');
      List<String> list;
      if (prefs.getStringList("notification_data") != null) {
        list = prefs.getStringList("notification_data")!;
      } else {
        list = [];
      }
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        DateTime now = DateTime.now();
        String date = DateTime.now().toString();
        list.add(json.encode({
          'notification_hascode': notification.hashCode,
          'notification_title': notification.title,
          'notification_body': notification.body,
          'notification_time': date,
        }));
        prefs.setStringList("notification_data", list);
        print(list);
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title!),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body!)],
                ),
              ),
            );
          },
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FigmaToCodeApp());
  }
}


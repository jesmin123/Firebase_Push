import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app001/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true
              )
            )
        );

      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new onMessageOpenedApp event was published");
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        showDialog(context: context,
            builder: (_) {
          return AlertDialog(
            title: Text(notification.title!),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.body!)
                ],
              ),
            ),
          );

            });
      }

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            showNotification();
          },
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.blue),
            child: Center(
              child: Text("Click Me"),
            ),
          ),
        ),
      ),
    );
  }
  void showNotification(){
    flutterLocalNotificationsPlugin.show(
        001,
        " Greetings",
        "Nice to meet you Sir",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true
          )
        )
    );
  }
}

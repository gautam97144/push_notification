import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


 void initNotification()async {
   var androidInitialization = const AndroidInitializationSettings(
       "@mipmap/ic_launcher");
   var iosInitialization = const DarwinInitializationSettings();


   InitializationSettings initializationSettings = InitializationSettings(
       iOS: iosInitialization,
       android: androidInitialization
   );


  await  flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    onDidReceiveNotificationResponse: (payload){
    
    }
  );

 }

 firebaseInit(){
   FirebaseMessaging.onMessage.listen((message) {
     showNotification(message);

   });

   FirebaseMessaging.onMessageOpenedApp.listen((message){
     showNotification(message);

   });
 }

 Future<void> showNotification(RemoteMessage message)async {
   AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails("1", "this is notification",
     importance: Importance.high,
     priority: Priority.high,
     ticker: 'ticker'
   );
   DarwinNotificationDetails darwinNotificationDetails =  const DarwinNotificationDetails(
     presentSound: true,
     presentAlert: true,
     presentBadge: true

   );

   NotificationDetails notificationDetails =NotificationDetails(
     android: androidNotificationDetails,
     iOS: darwinNotificationDetails
   );
   await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body,notificationDetails);
 }

  void requestPermission()async{
     await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }


  getDeviceToken()async{
   String? token = await  messaging.getToken();
   print(token);
   return token;
  }



}

class SendNotification{


  sendNotificationMethod({
    String? title,
    String? mainData,
    String? message,
})async{

    FirebaseMessaging firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    String? deviceToken = await firebaseMessaging.getToken();

    const postUrl = 'https://fcm.googleapis.com/fcm/send';



    final data = {
      "registration_ids": [deviceToken],
      "notification": {
        "title": "$title",
        "body": mainData,
      },
      "android": {
        "notification": {"channel_id": "bringvendor"}
      },
      "data": {
        "action": message,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      }
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization':
      'key=AAAAowVxj-4:APA91bHiq7DX1Q8q6a77XWP2nTSVvvZNo4reMt0ANE2ayCLA1IyeAFkUEOigt59kimiR719PhNWaoQnm8-jW2dcv4VkdR3jc-PLnSVToy6PG3gYmvb8MnsEAvbKt-k59OlR6JDzd3VTT'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);


    if(response.statusCode==200){
      print(response.body);
    }

  }

}
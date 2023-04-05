import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';


Future<void> backgroundMessageHandler(RemoteMessage message)async{

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      home: Home(),
    );
  }
}

// "AAAAowVxj-4:APA91bHiq7DX1Q8q6a77XWP2nTSVvvZNo4reMt0ANE2ayCLA1IyeAFkUEOigt59kimiR719PhNWaoQnm8-jW2dcv4VkdR3jc-PLnSVToy6PG3gYmvb8MnsEAvbKt-k59OlR6JDzd3VTT"
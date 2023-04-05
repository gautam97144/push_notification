import 'package:flutter/material.dart';
import 'package:push_notification/notification_service/notification_service.dart';

class  Home extends StatefulWidget {
  const Home  ({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  NotificationService notificationService =NotificationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   notificationService.initNotification();
    notificationService.requestPermission();
    notificationService.firebaseInit();

    //var token =notificationService.getDeviceToken();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Notification Demo"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            SendNotification().sendNotificationMethod(
              title: "gautam",mainData: "this is notification"
            );
          }, child: const Text("Send Notification"),
        ),
      ),
    );
  }
}

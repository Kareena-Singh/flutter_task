import 'package:flutter/material.dart';
import 'package:flutter_task/views/HomeScreen.dart';
import 'package:get/get.dart';
import 'services/notifications.dart';
import 'services/background_task.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService.init(); // Initialize notifications
  print("NotificationService initialized"); // Debug log

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask("task-identifier", "simpleTask",
      frequency: Duration(minutes: 15));

  runApp(MyApp());

  // Show notification 3 seconds after the app starts (for testing)
  Future.delayed(Duration(seconds: 3), () {
    print("Calling showNotification() after 3 seconds"); // Debug log
    NotificationService.showNotification();
  });
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

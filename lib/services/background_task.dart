import 'package:workmanager/workmanager.dart';
import 'notifications.dart';

// Callback function that will be executed when the background task is triggered
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Background task executed: $task"); // Debug log
    NotificationService.showNotification();
    // Returning true to indicate successful execution of the background task
    return Future.value(true);
  });
}

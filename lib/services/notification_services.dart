import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NotificationServices {
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'takePhoto_channel',
          channelName: 'Take Photo',
          channelDescription: 'Notification channel for taking photos',
          importance: NotificationImportance.High,
          playSound: true,
        ),
      ],
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.payload?['action'] == 'open_camera') {
      await launchCameraApp();
    }
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("Notification created");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("Notification displayed");
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("Notification dismissed");
  }

  static Future<void> displayNotification({
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'takePhoto_channel',
        title: title,
        body: body,
        payload: {'action': 'open_camera'},
      ),
    );
  }

  static Future<void> launchCameraApp() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      debugPrint('Photo captured: ${photo.path}');
    } else {
      debugPrint('No photo captured.');
    }
  }
}

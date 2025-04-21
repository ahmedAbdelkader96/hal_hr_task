


import 'dart:isolate';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task/features/authentication/controller/controller.dart';

class Isolates {
  static void sendNotification(Map<String, dynamic> message) {
    SendPort sendPort = message['send_port'];
    bool isNew = message['isNew'];
    String externalId = message['externalId'];


    sendPort.send(isNew ? 'New user notification' : 'Returning user notification');
  }

  static Future<void> executeSendNotificationInBackground(
      bool isNew,
      String externalId
      ) async {
    final receivePort = ReceivePort();

    final message = {'send_port': receivePort.sendPort, 'isNew': isNew,'externalId':externalId};

    await Isolate.spawn(sendNotification, message);
    receivePort.listen((result) {
      // Handle the result here
      print(result); // This is a simple message; you can handle it as needed.
      receivePort.close(); // Close the receive port when done

      // Call the sendNotification method from the main isolate after getting the message
      print("////////************---------externalId is ${externalId}");
      AuthController().sendNotification(
        title: isNew ? "Congratulations!" : "Welcome Back!",
        body: isNew
            ? "Your account created successfully, welcome to Hal Hr Application"
            : "Welcome Back to Hal Hr Application",
          externalId:externalId
      );
    });
  }
}
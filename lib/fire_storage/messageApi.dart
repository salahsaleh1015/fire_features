import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageApi extends StatefulWidget {
  const MessageApi({Key? key}) : super(key: key);

  @override
  _MessageApiState createState() => _MessageApiState();
}

class _MessageApiState extends State<MessageApi> {
  var fbm = FirebaseMessaging.instance;
  final String serverToken =
      'AAAAZ03eHGg:APA91bH5E8hRA_3uBzNZcJNdMpSiNhaaEfeLhMjNtQ3HUgl5_6csGsnemrpL-PafD01qPeJkkGSr52uNVXtFQ8jgSg6iOow3pyGJkBKM45k43gfKJ0Kbdvd7yNEPuBgc3bOJ8HK6lp_E';
  sendNotify(String body, String title, String id) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString(),
            'status': 'done'
          },
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }
  getMessage()async{
    print("======== message body ===========");
    FirebaseMessaging.onMessage.listen((event) {
      print('${event.notification!.body}');
      print('${event.notification!.title}');

    });
    print("===================");
  }
@override
  void initState() {

  getMessage();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

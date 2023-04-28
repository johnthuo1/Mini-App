// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_import, unnecessary_import

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:overlay_support/overlay_support.dart';

import '../model/push_notification.dart';
import 'package:booksgrid/model/chart_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

 
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}
 
class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
        
      ),
      body: ListView.builder(
        itemCount: ChatModel.dummyData.length,
        itemBuilder: (context, index) {
          ChatModel model = ChatModel.dummyData[index];
          return Column(
            children: <Widget>[
              const Divider(
                height: 12.0,
              ),
              // InkWell to make the ListTile tappable
              InkWell(
                onTap: () {
                  // Navigate to a new page on tile tap
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPage(model: model),
                  ));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24.0,
                    backgroundImage: NetworkImage(model.avatarUrl),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(model.name),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        model.datetime,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  subtitle: Text(model.message),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14.0,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// DetailPage widget for displaying the details of a notification
class DetailPage extends StatelessWidget {
  final ChatModel model;

  const DetailPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
     
            const SizedBox(
              height: 16.0,
            ),
            Text(
              model.message,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              model.datetime,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Go back to the previous screen
                  Navigator.of(context).pop();
                },
                child: const Text('Go Back'),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (kDebugMode) {
//     print("Handling a background message: ${message.messageId}");
//   }
// }

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({Key? key}) : super(key: key);

//   @override
//   _NotificationsPageState createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   late final FirebaseMessaging _messaging;
//   late int _totalNotifications;
//   PushNotification? _notificationInfo;

//   void registerNotification() async {
//     await Firebase.initializeApp();
//     _messaging = FirebaseMessaging.instance;

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       if (kDebugMode) {
//         print('User granted permission');
//       }

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         if (kDebugMode) {
//           print(
//             'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
//         }

//         // Parse the message received
//         PushNotification notification = PushNotification(
//           title: message.notification?.title,
//           body: message.notification?.body,
//           dataTitle: message.data['title'],
//           dataBody: message.data['body'],
//         );

//         setState(() {
//           _notificationInfo = notification;
//           _totalNotifications++;
//         });

//         if (_notificationInfo != null) {
//           // For displaying the notification as an overlay
//           showSimpleNotification(
//             Text(_notificationInfo!.title!),
//             leading: NotificationBadge(totalNotifications: _totalNotifications),
//             subtitle: Text(_notificationInfo!.body!),
//             background: Colors.cyan.shade700,
//             duration: Duration(seconds: 2),
//           );
//         }
//       });
//     } else {
//       if (kDebugMode) {
//         print('User declined or has not accepted permission');
//       }
//     }
//   }

//   // For handling notification when the app is in terminated state
//   checkForInitialMessage() async {
//     await Firebase.initializeApp();
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       PushNotification notification = PushNotification(
//         title: initialMessage.notification?.title,
//         body: initialMessage.notification?.body,
//         dataTitle: initialMessage.data['title'],
//         dataBody: initialMessage.data['body'],
//       );

//       setState(() {
//         _notificationInfo = notification;
//         _totalNotifications++;
//       });
//     }
//   }

//   @override
//   void initState() {
//     _totalNotifications = 0;
//     registerNotification();
//     checkForInitialMessage();

//     // For handling notification when the app is in background
//     // but not terminated
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       PushNotification notification = PushNotification(
//         title: message.notification?.title,
//         body: message.notification?.body,
//         dataTitle: message.data['title'],
//         dataBody: message.data['body'],
//       );

//       setState(() {
//         _notificationInfo = notification;
//         _totalNotifications++;
//       });
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Notifications'), systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'App for capturing Firebase Push Notifications',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//             ),
//           ),
//           SizedBox(height: 16.0),
//           NotificationBadge(totalNotifications: _totalNotifications),
//           SizedBox(height: 16.0),
//           _notificationInfo != null
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ],
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }

// class NotificationBadge extends StatelessWidget {
//   final int totalNotifications;

//   const NotificationBadge({Key? key, required this.totalNotifications}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40.0,
//       height: 40.0,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             '$totalNotifications',
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
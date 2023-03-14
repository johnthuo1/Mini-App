import 'package:flutter/material.dart';
import 'package:booksgrid/model/chart_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

 
  @override
  // ignore: library_private_types_in_public_api
  _NotificationsPageState createState() => _NotificationsPageState();
}
 
class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notifications'),
        
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
 
              // List tile
              ListTile(
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
            ],
          );
        },
      ),
    );
  }
}
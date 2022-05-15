import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final _notfications = FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: FutureBuilder(
                future: _notfications.pendingNotificationRequests(),
                builder: (context,ss){
                  if(ss.hasError){
                    print('Error');
                  }
                  if(ss.hasData){
                    List? appointments = ss.data as List?;
                    return ListView.builder(
                        itemCount: appointments!.length,
                        itemBuilder: (context,position){
                          return Card(
                            child: Column(
                              children: <Widget>[
                                Text('id: ${appointments[position].id}'),
                                Text('title: ${appointments[position].title}'),
                                Text('body: ${appointments[position].body}'),
                              ],
                            ),
                          );
                        });
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            ElevatedButton(onPressed: (){
              _notfications.cancelAll();
              setState(() {

              });
            }, child: Text("Cancel All"))
          ],
        ),
      ),
    );
  }
}

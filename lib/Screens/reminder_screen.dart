import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Constants.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final _notfications = FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 20),
                  child: Text(
                    "REMINDERS",
                    style: BasicTitle,
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.7,
                child: FutureBuilder(
                  future: _notfications.pendingNotificationRequests(),
                  builder: (context, ss) {
                    if (ss.hasError) {
                      print('Error');
                    }
                    if (ss.hasData) {
                      List? appointments = ss.data as List?;
                      return (appointments!.isNotEmpty)
                          ? ListView.builder(
                              itemCount: appointments.length,
                              itemBuilder: (context, position) {
                                return reminderCard(
                                    appointments[position].id,
                                    appointments[position].title.toString(),
                                    appointments[position].body.toString());
                              })
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("No reminders! Set now"),
                            );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: size.width*0.5,
                  height: size.height*0.055,
                  child: ElevatedButton(
                    onPressed: () {
                      _notfications.cancelAll();
                      setState(() {});
                    },
                    child: Text("Cancel All"),
                    style: ElevatedButton.styleFrom(primary: buttonColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget reminderCard(id, title, description) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ExpansionTile(
        collapsedBackgroundColor: buttonColor,
        backgroundColor: buttonColor,
        title: Text(
          title,
          style: resourceStyle,
        ),
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(20),
            subtitle: ElevatedButton(
              onPressed: () {
                _notfications.cancel(id);
                setState(() {});
              },
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(primary: Color(0xffff6961)),
            ),
            title: Text(
              description,
              style: resourceStyle,
            ),
          )
        ],
      ),
    );
  }
}

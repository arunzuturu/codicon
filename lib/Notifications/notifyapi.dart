
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createBasicNotification(String text) async {
  await AwesomeNotifications().createNotification(content: NotificationContent(id: 4, channelKey: 'basic_channel',
    title: '${Emojis.animals_fly} $text',
    body: "First notification"
  ));
}
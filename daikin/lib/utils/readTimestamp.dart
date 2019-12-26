import 'package:intl/intl.dart';

String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('HH:mm a', "vi_VN");
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' ngày trước';
    } else {
      time = diff.inDays.toString() + ' ngày trước';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' tuần trước';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' tuần trước';
    }
  }

  return time;
}

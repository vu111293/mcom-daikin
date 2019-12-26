import 'package:timeago/timeago.dart' as timeago;

String formatTime(String time) {
  var result = timeago.format(DateTime.parse(time).toLocal(), locale: 'vi');
  if (result == "một thoáng trước") {
    return "khoảng một phút trước";
  }

  return result;
}

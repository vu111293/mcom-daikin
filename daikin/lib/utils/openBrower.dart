import 'package:url_launcher/url_launcher.dart';

///not support simulator IOS
openWebBrowerhURL(url) async {
  if (url != '') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

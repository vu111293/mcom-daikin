import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Html(data: '');
  }
}

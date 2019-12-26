import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheUtils {
  static const LOCAL_DB = 'colleaguesdb';

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static dynamic loadJsonDB(String name) async {
    final path = await _localPath;
    try {
      final file = File('$path/$LOCAL_DB/$name');
      String contents = await file.readAsString();
      return contents == null ? null : json.decode(contents);
    } catch (e) {
      return null;
    }
  }

  static dynamic deleteJsonDB(String name) async {
    final path = await _localPath;
    try {
      final file = File('$path/$LOCAL_DB/$name');
      if (file.existsSync()) file.deleteSync();
    } catch (e) {}
  }

  static void saveJsonDB(String name, String raw) async {
    final path = await _localPath;
    try {
      final file = File('$path/$LOCAL_DB/$name');
      if (!file.existsSync()) file.create(recursive: true);
      await file.writeAsString(raw);
    } catch (e) {
      print(e);
    }
  }
}

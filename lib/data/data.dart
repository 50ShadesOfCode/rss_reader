import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:windows1251/windows1251.dart';
import 'package:http/http.dart' as http;

class Data{

  static const String feedUrl = 'https://alfabank.ru/_/rss/_rss.html?subtype=1&category=2&city=21';

  static Future<String> get tempPath async{
    Directory dir = await getTemporaryDirectory();
    return dir.path;
  }

  static Future<File> get tempFile async{
    final path = await tempPath;
    return File('$path/rss.xml');
  }

  static Future<void> updateFile() async {
    try {
      final file = await tempFile;
      final response = await http.get(Uri.parse(feedUrl));
      final resdec = windows1251.decode(response.bodyBytes);
      file.deleteSync();
      file.writeAsString(resdec);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> createFile() async{
    try {
      final file = await tempFile;
      final response = await http.get(Uri.parse(feedUrl));
      final resdec = windows1251.decode(response.bodyBytes);
      file.writeAsString(resdec);
    } catch (e) {
      print(e);
    }
  }
}
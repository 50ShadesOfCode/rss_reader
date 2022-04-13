import 'package:untitled/data/data.dart';
import 'package:windows1251/windows1251.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

class SyncService {
  static const String feedUrl = 'https://alfabank.ru/_/rss/_rss.html?subtype=1&category=2&city=21';
  Future<void> updateData() async {
    try {
      final file = await Data.tempFile;
      final response = await http.get(Uri.parse(feedUrl));
      final resdec = windows1251.decode(response.bodyBytes);
      file.deleteSync();
      file.writeAsString(resdec);
    } catch (e) {
      print(e);
    }
  }
}

final getIt = GetIt.instance;

setupServiceLocator(){
  getIt.registerLazySingleton<SyncService>(() => SyncService());
}


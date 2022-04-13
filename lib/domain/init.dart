import 'package:untitled/data/data.dart';

class Init{

  static Future initialize() async {
    final file = await Data.tempFile;
    if (file.existsSync() == false){
      await Data.createFile();
    }
    else{
      await Data.updateFile();
    }
  }

}
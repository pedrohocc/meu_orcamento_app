import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class SaveFile {
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final String url = "$path/$fileName";
    final File file = File(url);

    await file.writeAsBytes(bytes, flush: true);

    OpenFilex.open(url);
  }
}

import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SaveFile {
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final Directory directory = await getApplicationSupportDirectory();
    final String path = directory.path;
    final String url = "$path/$fileName";
    final File file = File(url);

    await file.writeAsBytes(bytes, flush: true);

    OpenFile.open(url);
  }
}

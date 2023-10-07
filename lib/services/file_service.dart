import 'package:markdown_editor/data/file_data_source.dart';
import 'package:markdown_editor/models/file_model.dart';

abstract class FileService {
  static Future<FileModel> pickFile() => FileDataSource.pickFile();

  static Future<void> saveFile(FileModel file) => FileDataSource.saveFile(file);
}

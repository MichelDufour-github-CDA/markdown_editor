import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:markdown_editor/models/file_model.dart';

abstract class FileDataSource {
  static Future<FileModel> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['md'],
    );

    if (result == null) throw Exception('Aucun fichier sélectionné');

    if (result.files.single.path == null) {
      throw Exception("Erreur : Impossible d'obtenir le chemin d'accès au fichier");
    }

    final file = File(result.files.single.path!);

    return FileModel(
      path: file.path,
      content: await file.readAsString(),
    );
  }
}

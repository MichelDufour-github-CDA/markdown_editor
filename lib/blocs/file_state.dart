import 'package:markdown_editor/models/file_model.dart';

abstract class FileState {}

class FileStateInitial extends FileState {}

class FileStateLoading extends FileState {}

class FileStateLoaded extends FileState {
  final FileModel file;

  FileStateLoaded({
    required this.file,
  });
}

class FileStateError extends FileState {
  final String message;

  FileStateError({
    required this.message,
  });
}

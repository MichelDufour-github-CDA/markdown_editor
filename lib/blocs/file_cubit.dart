import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editor/blocs/file_state.dart';
import 'package:markdown_editor/models/file_model.dart';
import 'package:markdown_editor/services/file_service.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileStateInitial());

  FileModel? _fileModel;

  Future<void> pickFile() async {
    emit(FileStateLoading());

    try {
      _fileModel = await FileService.pickFile();
      if (_fileModel != null) {
        emit(FileStateLoaded(file: _fileModel!));
      }
    } catch (e) {
      emit(FileStateError(message: e.toString()));
    }
  }

  Future<void> editFile(String newValue) async {
    _fileModel = _fileModel?.copyWith(content: newValue);
    if (_fileModel != null) {
      emit(FileStateLoaded(file: _fileModel!));
    }
  }

  Future<void> saveFile() async {
    if (_fileModel != null) FileService.saveFile(_fileModel!);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editor/blocs/file_state.dart';
import 'package:markdown_editor/services/file_service.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileStateInitial());

  Future<void> pickFile() async {
    emit(FileStateLoading());

    try {
      final file = await FileService.pickFile();
      emit(FileStateLoaded(file: file));
    } catch (e) {
      emit(FileStateError(message: e.toString()));      
    }
  }
}
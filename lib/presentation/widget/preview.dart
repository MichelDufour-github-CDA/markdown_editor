import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editor/blocs/file_cubit.dart';
import 'package:markdown_editor/blocs/file_state.dart';

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileCubit, FileState>(
      builder: (context, state) {
        if (state is FileStateLoaded) {
          return Markdown(data: state.file.content);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
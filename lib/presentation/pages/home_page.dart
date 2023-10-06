import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editor/blocs/file_cubit.dart';
import 'package:markdown_editor/blocs/file_state.dart';
import 'package:markdown_editor/presentation/widget/editor.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context) => BlocProvider<FileCubit>(
        create: (_) => FileCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Markdown Editor'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<FileCubit>().pickFile();
                  },
                  icon: const Icon(
                    Icons.file_copy_outlined,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: BlocBuilder<FileCubit, FileState>(
              builder: (context, state) {
                if (state is FileStateLoaded) {
                  return Editor(initialContent: state.file.content);
                } else if (state is FileStateError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is FileStateInitial) {
                  return const Center(
                    child: Text('Pick a file !'),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        }),
      );
}

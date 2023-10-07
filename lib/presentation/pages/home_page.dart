// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_editor/blocs/file_cubit.dart';
import 'package:markdown_editor/blocs/file_state.dart';
import 'package:markdown_editor/presentation/pages/preview_page.dart';
import 'package:markdown_editor/presentation/widget/editor.dart';
import 'package:markdown_editor/presentation/widget/preview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Markdown Editor'),
          actions: [
            Tooltip(
              message: 'Choisir un fichier',
              child: IconButton(
                onPressed: () {
                  context.read<FileCubit>().pickFile();
                },
                icon: const Icon(
                  Icons.file_copy_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            BlocBuilder<FileCubit, FileState>(builder: (context, state) {
              if (state is FileStateLoaded) {
                return Tooltip(
                  message: 'Aperçu',
                  child: IconButton(
                    onPressed: () {
                      context.pushNamed(PreviewPage.name);
                    },
                    icon: const Icon(
                      Icons.preview_outlined,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            BlocBuilder<FileCubit, FileState>(builder: (context, state) {
              if (state is FileStateLoaded) {
                return Tooltip(
                  message: 'Save',
                  child: IconButton(
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text('Are you sure ?'),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context.pop(true);
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.pop(false);
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (result == true) {
                        context.read<FileCubit>().saveFile();
                      }
                    },
                    icon: const Icon(
                      Icons.save_outlined,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
        body: BlocBuilder<FileCubit, FileState>(
          builder: (context, state) {
            if (state is FileStateLoaded) {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 1000) {
                  return Editor(initialContent: state.file.content);
                }
                return Row(
                  children: [
                    Expanded(
                      child: Editor(initialContent: state.file.content),
                    ),
                    const Expanded(
                      child: Preview(),
                    )
                  ],
                );
              });
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
}

import 'package:flutter/material.dart';
import 'package:markdown_editor/presentation/widget/preview.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  static const name = 'preview';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Markdown Editor : Preview'),
        ),
        body: const Preview()
      );
}

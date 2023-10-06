import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  const Editor({
    super.key,
    required this.initialContent,
  });

  final String initialContent;

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialContent;
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        expands: true,
        maxLines: null,
      );
}

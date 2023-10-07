class FileModel {
  final String path;
  final String content;

  FileModel({
    required this.path,
    required this.content,
  });

  FileModel copyWith({String? path, String? content}) {
    return FileModel(
      path: path ?? this.path,
      content: content ?? this.content,
    );
  }
}

class PostModel {
  final int id;
  final String title;
  final String body;

  const PostModel({required this.id, required this.title, required this.body});

  // TODO: Why factory?
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(id: json['id'], title: json['title'], body: json['body']);
}

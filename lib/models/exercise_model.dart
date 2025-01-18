class Exercise {
  final int id;
  final String title;
  final String type; // text or image
  final String content; // text or image URL
  final bool isEnabled;

  Exercise(
      {required this.id,
      required this.title,
      required this.type,
      required this.content,
      required this.isEnabled});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      content: json['content'],
      isEnabled: json['is_enabled'],
    );
  }
}

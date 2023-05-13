class MeditationEx {
  final String id;
  final String title;
  final String category;
  final String duration;
  final String description;
  final String videoUrl;
  final String imageUrl;
  List isDone;

  MeditationEx(
      {required this.title,
      required this.id,
      required this.category,
      required this.description,
      required this.duration,
      required this.videoUrl,
      required this.imageUrl,
      required this.isDone});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "id": id,
      "description": description,
      "duration": duration,
      "videoUrl": videoUrl,
      "imageUrl": imageUrl,
      "isDone": isDone
    };
  }

  static MeditationEx fromJson(var snap) {
    var snapshot = snap as Map<String, dynamic>;
    return MeditationEx(
      id: snapshot['id'],
      title: snapshot['title'],
      category: snapshot['category'],
      description: snapshot['description'],
      duration: snapshot['duration'],
      videoUrl: snapshot['videoUrl'],
      imageUrl: snapshot['imageUrl'],
      isDone: snapshot['isDone'],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class Song {
  final String id;
  final String title;
  final String category;
  final String duration;
  final String description;
  final String songUrl;
  final String imageUrl;
  List isFavourite;

  Song(
      {required this.title,
      required this.id,
      required this.category,
      required this.description,
      required this.duration,
      required this.isFavourite,
      required this.songUrl,
      required this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "id": id,
      "description": description,
      "duration": duration,
      "songUrl": songUrl,
      "imageUrl": imageUrl,
      "isFavourite": isFavourite,
    };
  }

  static Song fromJson(var snap) {
    var snapshot = snap as Map<String, dynamic>;
    return Song(
      id: snapshot['id'],
      title: snapshot['title'],
      category: snapshot['category'],
      description: snapshot['description'],
      duration: snapshot['duration'],
      songUrl: snapshot['songUrl'],
      imageUrl: snapshot['imageUrl'],
      isFavourite: snapshot['isFavourite'],
    );
  }

  bool isFavorite(String id) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    return isFavourite.contains(uid);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/song.dart';

class MusicsController with ChangeNotifier {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  int selectedIndex = 0;
  final List<Song> _items = [];
  List<Song> _currentSongs = [];
  List<String> _categories = ['All', 'My'];
  final List<Song> _relatedSong = [];

  List<Song> get relatedSong => [..._relatedSong];
  List<Song> get songs => [..._items];
  List<Song> get filterSongs => [..._currentSongs];
  List<String> get categories => [..._categories];

  Future<List<Song>> getAllSongs() async {
    try {
      await FirebaseFirestore.instance.collection('musics').get().then((value) {
        _items.clear();
        _categories.clear();
        _categories = ['All', 'My'];

        for (var i in value.docs) {
          Song song = Song.fromJson(i.data());
          _categories.add(song.category.capitalize());
          _items.add(song);
        }
      });
      // for (var element in _items) {
      //   print(element.isFavourite);
      // }
      _categories = _categories.toSet().toList();
      notifyListeners();

      return [..._items];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getFilterSongs(int currentIndex) async {
    selectedIndex = currentIndex;
    try {
      _currentSongs.clear();
      if (currentIndex == 0) {
        _currentSongs = await getAllSongs();
        notifyListeners();
        return;
      }
      for (var element in _items) {
        if (element.category.toLowerCase() ==
            _categories[currentIndex].toLowerCase()) {
          _currentSongs.add(element);
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<List<Song>> getRelatedSong(String id, String category) async {
    try {
      _relatedSong.clear();
      for (var element in _items) {
        if (element.id != id && element.category == category) {
          _relatedSong.add(element);
        }
      }
      return [..._relatedSong];
    } catch (e) {
      rethrow;
    }
  }

  Future<Song> changeFavourite(String songId, String category) async {
    var song = _items.indexWhere((element) {
      return element.id == songId;
    });
    print(_items[song].isFavourite.contains(uid));
    if (_items[song].isFavourite.contains(uid)) {
      await FirebaseFirestore.instance.collection('musics').doc(songId).update({
        'isFavourite': FieldValue.arrayRemove([uid])
      });
      _items[song].isFavourite.remove(uid);
      getFilterSongs(selectedIndex);
    } else {
      await FirebaseFirestore.instance.collection('musics').doc(songId).update({
        'isFavourite': FieldValue.arrayUnion([uid])
      });
      _items[song].isFavourite.add(uid);
      getFilterSongs(selectedIndex);
    }
    return _items[song];
  }

  bool isFavourite(String songId) {
    var song = _items.indexWhere((element) {
      return element.id == songId;
    });
    return _items[song].isFavourite.contains(uid);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

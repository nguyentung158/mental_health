import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/song.dart';

class MusicsController with ChangeNotifier {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  int selectedIndex = 0;
  final List<Song> _items = [];
  List<Song> _currentSongs = [];
  final List<Song> _favouriteSongs = [];
  List<String> _categories = ['All', 'My'];
  final List<Song> _relatedSong = [];

  List<Song> get relatedSong => [..._relatedSong];
  List<Song> get songs => [..._items];
  List<Song> get filterSongs => [..._currentSongs];
  List<Song> get favouriteSongs => [..._favouriteSongs];
  List<String> get categories => [..._categories];

  Future<List<Song>> getAllSongs() async {
    try {
      await FirebaseFirestore.instance.collection('musics').get().then((value) {
        _items.clear();
        _favouriteSongs.clear();
        _categories.clear();
        _categories = ['All', 'My'];

        for (var i in value.docs) {
          Song song = Song.fromJson(i.data());
          _categories.add(song.category.capitalize());
          _items.add(song);

          if (song.isFavourite.contains(uid)) {
            _favouriteSongs.add(song);
          }
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
      if (currentIndex == 1) {
        _currentSongs = favouriteSongs;
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
    if (_items[song].isFavourite.contains(uid)) {
      await FirebaseFirestore.instance.collection('musics').doc(songId).update({
        'isFavourite': FieldValue.arrayRemove([uid])
      });
      _items[song].isFavourite.remove(uid);
      _favouriteSongs.remove(_items[song]);
      getFilterSongs(selectedIndex);
    } else {
      await FirebaseFirestore.instance.collection('musics').doc(songId).update({
        'isFavourite': FieldValue.arrayUnion([uid])
      });
      _items[song].isFavourite.add(uid);
      _favouriteSongs.add(_items[song]);
      getFilterSongs(selectedIndex);
    }
    return _items[song];
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

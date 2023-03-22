import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/song.dart';

class MusicsController with ChangeNotifier {
  int selectedIndex = 0;
  final List<Song> _items = [];
  List<Song> _currentSongs = [];
  List<String> _categories = ['All', 'My'];
  List<Song> _relatedSong = [];

  List<Song> get relatedSong => [..._relatedSong];
  List<Song> get songs => [..._items];
  List<Song> get filterSongs => [..._currentSongs];
  List<String> get categories => [..._categories];

  Future<void> getAllSongs() async {
    try {
      await FirebaseFirestore.instance.collection('musics').get().then((value) {
        _items.clear();
        for (var i in value.docs) {
          List list = i['songs'];
          for (var element in list) {
            _items.add(Song.fromJson(element));
          }
        }
      });

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getFilterSongs(int currentIndex) async {
    selectedIndex = currentIndex;
    try {
      _currentSongs.clear();
      if (currentIndex == 0) {
        _currentSongs = [..._items];
        notifyListeners();
        return;
      }
      for (var element in _items) {
        if (element.category.split(' ')[0].toLowerCase() ==
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

  Future<void> getCategories() async {
    try {
      var data = await FirebaseFirestore.instance.collection('musics').get();
      _categories.clear();
      _categories = ['All', 'My'];
      for (var element in data.docs) {
        _categories.add(element.id.toString().capitalize());
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Song>> getRelatedSong(String id, String category) async {
    try {
      print('object');
      _relatedSong.clear();
      await getAllSongs();
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
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

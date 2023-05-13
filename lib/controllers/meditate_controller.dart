import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/meditation_ex.dart';

class MeditateController with ChangeNotifier {
  final List<String> _playlistTitle = [];
  Timer? _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  List<String> get playlistTitle => [..._playlistTitle];

  Future<bool> loadAll() async {
    await loadPlaylist();
    return true;
  }

  Future<List<Map<String, dynamic>>> loadCoursesList(String title) async {
    List<Map<String, dynamic>> datalist = [];
    var data = await FirebaseFirestore.instance
        .collection('meditation_playlist')
        .doc(title)
        .collection('courses')
        .get()
        .then((value) {
      value.docs.toList().forEach((element) {
        datalist.add({
          'title': element.id,
          'imageUrl': element.data()['imageUrl'],
          'description': element.data()['description']
        });
      });
    });
    return datalist;
  }

  Future<List<MeditationEx>> loadPlaylistItems(
      CollectionReference reference) async {
    try {
      List<MeditationEx> datalist = [];
      if (reference ==
          FirebaseFirestore.instance
              .collection('meditation_playlist')
              .doc('daily')
              .collection('daily')) {
        Map<String, dynamic> data = await loadReport();

        List<dynamic> his = data['history'];

        DateTime now = DateTime.now();
        String year = now.year.toString();
        String month = now.month.toString();
        String day = now.day.toString();

        if (day.length < 2) {
          day = '0$day';
        }
        if (month.length < 2) {
          month = '0$month';
        }
        String date = '$year-$month-$day';
        print(his.contains(date));

        if (his.contains(date)) {
          return datalist;
        }

        await reference
            .where('isDone',
                whereNotIn: [FirebaseAuth.instance.currentUser!.uid])
            .limit(1)
            .get()
            .then((value) {
              value.docs.toList().forEach((element) {
                datalist.add(MeditationEx.fromJson(element.data()));
              });
            });
        print(datalist);

        return datalist;
      }
      await reference.get().then((value) {
        value.docs.toList().forEach((element) {
          datalist.add(MeditationEx.fromJson(element.data()));
        });
      });
      print(datalist);
      return datalist;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List> loadPlaylist() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('meditation_playlist');
    QuerySnapshot querySnapshot =
        await collectionReference.orderBy("priority").get();
    _playlistTitle.clear();
    for (var element in querySnapshot.docs) {
      if (element.id != 'daily') {
        _playlistTitle.add(element.id.trim());
      }
    }
    return playlistTitle;
  }

  void startTimer() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer!.cancel();
    }
    notifyListeners();
  }

  void continueTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }

  Future<void> updateReport(String id) async {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();
    String day = now.day.toString();
    if (day.length < 2) {
      day = '0$day';
    }
    if (month.length < 2) {
      month = '0$month';
    }
    String date = '$year-$month-$day';
    await FirebaseFirestore.instance
        .collection('report')
        .doc('meditate report')
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('report')
        .update({
      'time': FieldValue.increment(seconds + minute * 60 + hour * 60 * 60),
      'sessions': FieldValue.arrayUnion([id]),
      'history': FieldValue.arrayUnion([date])
    });
  }

  Future<void> doneMeditationEx(
      CollectionReference reference, String id) async {
    await updateReport(id);
    await reference.doc(id).update({
      'isDone': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    });
    notifyListeners();
  }

  Future<bool> isMeditateDone(CollectionReference reference, String id) async {
    List list = [];
    await reference.doc(id).get().then((value) {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      list = data['isDone'] as List;
    });
    return list.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<Map<String, dynamic>> loadReport() async {
    Map<String, dynamic> data = {};
    await FirebaseFirestore.instance
        .collection('report')
        .doc('meditate report')
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc('report')
        .get()
        .then((value) {
      data = value.data() as Map<String, dynamic>;
    });
    return data;
  }
}

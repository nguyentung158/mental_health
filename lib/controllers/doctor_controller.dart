import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/doctor.dart';

class DoctorController with ChangeNotifier {
  bool isLoading = false;
  int val = 1;
  List<DoctorModel> _doctors = [];
  List<DoctorModel> _currentDoctors = [];
  List<DoctorModel> get doctors => [..._doctors];
  List<DoctorModel> get currentDoctors => [..._currentDoctors];

  Future<void> fetchAndSetData() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .orderBy('rating', descending: true)
        .get()
        .then((value) {
      _doctors = [];
      val = 1;
      for (var element in value.docs) {
        _doctors.add(DoctorModel.fromJson(element.data()));
      }
      _currentDoctors = doctors;
    });
  }

  Future<DoctorModel> getDoctorInfo(String uid) async {
    late DoctorModel doctorModel;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .get()
        .then((value) {
      doctorModel = DoctorModel.fromJson(value.data()!);
    });
    return doctorModel;
  }

  Future<void> searchDoctor(String name) async {
    isLoading = true;
    if (name.trim() == '') {
      fetchAndSetData();
    }
    await FirebaseFirestore.instance.collection('doctors').get().then((value) {
      _doctors = [];
      for (var element in value.docs) {
        if (element
            .data()['name']
            .toString()
            .toLowerCase()
            .contains(name.toLowerCase())) {
          _doctors.add(DoctorModel.fromJson(element.data()));
        }
      }
      _currentDoctors = doctors;
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> filterDoctors(int value) async {
    val = value;
    isLoading = true;
    notifyListeners();
    if (val == 1) {
      _currentDoctors = doctors;
      _currentDoctors.sort(
        (a, b) => b.rating.compareTo(a.rating),
      );
    } else if (val == 2) {
    } else {
      _currentDoctors = doctors
          .where((element) => element.isfavourite
              .contains(FirebaseAuth.instance.currentUser!.uid))
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> favouriteDoctor(String docId) async {
    await FirebaseFirestore.instance.collection('doctors').doc(docId).update({
      'isfavourite':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
    if (val == 3) {
      await filterDoctors(3);
    }
    notifyListeners();
  }

  Future<void> unfavouriteDoctor(String docId) async {
    await FirebaseFirestore.instance.collection('doctors').doc(docId).update({
      'isfavourite':
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });
    if (val == 3) {
      await filterDoctors(3);
    }
    notifyListeners();
  }

  Future<void> voteDoctor(String docId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(docId)
        .get()
        .then((value) async {
      DoctorModel doctorModel = DoctorModel.fromJson(value.data()!);
      int lastVotes = doctorModel.votes;
      if (data['Review'] == 'good') {
        doctorModel.goodReviews =
            (doctorModel.goodReviews / 100 * lastVotes + 1) /
                (lastVotes + 1) *
                100;
      } else {
        doctorModel.goodReviews = double.parse(
            ((doctorModel.goodReviews / 100 * lastVotes) /
                    (lastVotes + 1) *
                    100)
                .toStringAsFixed(2));
      }

      doctorModel.rating = double.parse(
          ((doctorModel.rating * lastVotes + data['Rating']) / (lastVotes + 1))
              .toStringAsFixed(2));
      doctorModel.satisfaction = double.parse(
          ((doctorModel.satisfaction * lastVotes + data['Satisfaction score']) /
                  (lastVotes + 1))
              .toStringAsFixed(2));
      doctorModel.votes++;
      doctorModel.totalScore = double.parse(((doctorModel.satisfaction +
                  doctorModel.goodReviews +
                  doctorModel.rating * 20) /
              3)
          .toStringAsFixed(2));
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(docId)
          .update(doctorModel.toJson());
    });
  }
}

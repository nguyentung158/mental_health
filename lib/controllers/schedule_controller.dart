import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/appointment.dart';
import 'package:mental_health_app/models/user.dart' as my;

class ScheduleController with ChangeNotifier {
  List<Appointment> upcomingAppointments = [];
  List<Appointment> pendingAppointments = [];
  List<Appointment> canceledAppointments = [];
  List<Appointment> completedAppointments = [];
  bool isLoading = false;
  int selectedIndex = -1;

  int selectCard(int index) {
    if (selectedIndex == index) {
      // Deselect the card
      selectedIndex = -1;
    } else {
      selectedIndex = index;
    }
    notifyListeners();
    return selectedIndex;
  }

  Future<void> fetchAndSetData() async {
    selectedIndex = -1;
    isLoading = false;
    await getUpcomingAppointments();
    await getCanceledAppointments();
    await getCompletedAppointments();
    await getPendingAppointments();
    notifyListeners();
  }

  Future<void> getUpcomingAppointments() async {
    upcomingAppointments = [];
    !my.User.isDoctor
        ? await FirebaseFirestore.instance
            .collection('appointments')
            .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'confirmed')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              upcomingAppointments.add(appointment);
            }
          })
        : await FirebaseFirestore.instance
            .collection('appointments')
            .where('doc_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'confirmed')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              upcomingAppointments.add(appointment);
            }
          });
  }

  Future<void> getPendingAppointments() async {
    pendingAppointments = [];
    !my.User.isDoctor
        ? await FirebaseFirestore.instance
            .collection('appointments')
            .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'pending')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              pendingAppointments.add(appointment);
            }
          })
        : await FirebaseFirestore.instance
            .collection('appointments')
            .where('doc_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'pending')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              pendingAppointments.add(appointment);
            }
          });
  }

  Future<void> getCanceledAppointments() async {
    canceledAppointments = [];
    !my.User.isDoctor
        ? await FirebaseFirestore.instance
            .collection('appointments')
            .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'canceled')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              canceledAppointments.add(appointment);
            }
          })
        : await FirebaseFirestore.instance
            .collection('appointments')
            .where('doc_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'canceled')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              canceledAppointments.add(appointment);
            }
          });
  }

  Future<void> getCompletedAppointments() async {
    completedAppointments = [];
    !my.User.isDoctor
        ? await FirebaseFirestore.instance
            .collection('appointments')
            .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'completed')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              completedAppointments.add(appointment);
            }
          })
        : await FirebaseFirestore.instance
            .collection('appointments')
            .where('doc_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('status', isEqualTo: 'completed')
            .get()
            .then((value) {
            for (var element in value.docs) {
              Appointment appointment = Appointment.fromJson(element.data());
              // appointment.image = image;
              completedAppointments.add(appointment);
            }
          });
  }

  Future<void> bookAppointment(String date, String time, String title,
      String subtitle, String uid, String docId) async {
    isLoading = true;
    notifyListeners();
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('appointments').doc();
    String id = documentReference.id;
    await documentReference.set({
      "id": id,
      "date": date,
      "time": time,
      "title": title,
      "subTitle": subtitle,
      "user_id": uid,
      "doc_id": docId,
      "status": "pending",
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> cancelAppointment(String id, String type) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('appointments').doc(id.trim());
    await documentReference.update({
      "status": "canceled",
    });
    if (type == 'pending') {
      Appointment appointment =
          pendingAppointments.firstWhere((element) => element.id == id);
      pendingAppointments.removeWhere(
        (element) => element.id == id,
      );
      canceledAppointments.add(appointment);
    } else {
      Appointment appointment =
          upcomingAppointments.firstWhere((element) => element.id == id);
      upcomingAppointments.removeWhere(
        (element) => element.id == id,
      );
      canceledAppointments.add(appointment);
    }

    notifyListeners();
  }

  Future<void> completeAppointment(String id) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('appointments').doc(id);
    await documentReference.update({
      "status": "completed",
    });
    notifyListeners();
  }

  Future<void> confirmedAppointment(String id) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('appointments').doc(id.trim());
    await documentReference.update({
      "status": "confirmed",
    });

    Appointment appointment =
        pendingAppointments.firstWhere((element) => element.id == id);
    pendingAppointments.removeWhere(
      (element) => element.id == id,
    );
    upcomingAppointments.add(appointment);
    notifyListeners();
  }

  Future<List<String>> getAvailableTime(String docId, String date) async {
    List<String> availableTimes = [
      '9:00 - 10:00',
      '10:00 - 11:00',
      '11:00 - 12:00',
      '12:00 - 13:00',
      '14:00 - 15:00',
      '15:00 - 16:00',
      '16:00 - 17:00',
      '17:00 - 18:00',
      '18:00 - 19:00',
      '19:00 - 20:00',
      '20:00 - 21:00',
    ];
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('doc_id', isEqualTo: docId)
        .where('date', isEqualTo: date)
        .where('status', isEqualTo: 'confirmed')
        .get()
        .then((value) {
      for (var element in value.docs) {
        availableTimes.remove(element.data()['time']);
      }
    });

    notifyListeners();
    return availableTimes;
  }
}

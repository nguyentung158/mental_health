import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_health_app/models/user.dart' as my_user;

class AuthController with ChangeNotifier {
  bool isLoading = false;
  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _pickedImage = File(pickedImage!.path);
    notifyListeners();
  }

  Future<String> uploadToStorage(File? image) async {
    if (image == null) {
      return 'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/117796916/original/cc9999c311fc59802ffb7be4c6ca872582ff79a3/draw-a-cute-and-nice-avatar-or-portrait-for-you.png';
    }
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> test() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100000));
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signUp(
      String email, String password, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 10000));
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String url = await uploadToStorage(_pickedImage);
      my_user.User user = my_user.User(
        name: data['name'],
        email: email,
        uid: userCredential.user!.uid,
        profilePhoto: url,
        gender: data['gender'],
        phoneNumber: data['phoneNumber'],
        dateOfBirth: data['dateOfBirth'],
        age: data['age'],
        goals: data['goals'],
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
      await FirebaseFirestore.instance
          .collection('report')
          .doc('meditate report')
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc('report')
          .set({'time': 0, 'sessions': [], 'history': []});
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}

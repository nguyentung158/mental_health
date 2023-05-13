import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_health_app/models/user.dart' as my;

class AccountController with ChangeNotifier {
  bool isLoading = false;
  my.User? _user;
  my.User? get userInfo => _user;
  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  Future<File?> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _pickedImage = File(pickedImage!.path);
    notifyListeners();
    return File(pickedImage.path);
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

  Future<bool> fetchAndSetAccount() async {
    try {
      _pickedImage = null;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        var snapshot = value.data();
        _user = my.User.fromJson(snapshot);
      });
    } catch (e) {
      rethrow;
    }
    return true;
  }

  Future<void> editProfile(
      String name, String email, String phoneNumber, String dateOfBirth) async {
    isLoading = true;
    notifyListeners();
    String? profilePhoto = userInfo!.profilePhoto;
    if (_pickedImage != null) {
      profilePhoto = await uploadToStorage(_pickedImage);
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userInfo?.uid)
        .update({
      'dateOfBirth': dateOfBirth,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePhoto': profilePhoto
    });
    await fetchAndSetAccount();
    isLoading = false;
    notifyListeners();
  }
}

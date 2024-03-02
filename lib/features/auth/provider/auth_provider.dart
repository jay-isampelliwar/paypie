import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paypie/features/home/view/home.dart';
import 'package:uuid/uuid.dart';

import '../view/otp.dart';
import '../view/registration.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String? verificationId;
  bool _sendOtpLoading = false;
  bool _verifyOtpLoading = false;
  bool _registerLoading = false;

  bool get sendOtpLoading => _sendOtpLoading;
  bool get verifyLoading => _verifyOtpLoading;
  bool get registerLoading => _registerLoading;

  void setSendOtpLoading(bool value) {
    _sendOtpLoading = value;
    notifyListeners();
  }

  void setVerifyOtpLoading(bool value) {
    _verifyOtpLoading = value;
    notifyListeners();
  }

  void setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  Future<void> sendOtp(String phoneNumber, context) async {
    setSendOtpLoading(true);
    log(phoneNumber);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) async {
          log(e.toString());
          setSendOtpLoading(false);
        },
        codeSent: (String verificationId, int? resendToken) async {
          setSendOtpLoading(false);
          notifyListeners();
          this.verificationId = verificationId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(phoneNumber: phoneNumber),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
      );
    } catch (e) {
      setSendOtpLoading(false);
    }
  }

  Future<void> verifyOtp(String otp, context) async {
    setVerifyOtpLoading(true);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: otp);

    try {
      await _auth.signInWithCredential(credential);
      setVerifyOtpLoading(false);
      bool userExists = await isUserExists(_auth.currentUser!.phoneNumber!);

      if (userExists) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const RegistrationScreen()),
            (route) => false);
      }
    } on FirebaseException catch (e) {
      setVerifyOtpLoading(false);
      log(e.toString());
    }
  }

  Future<bool> isUserExists(String phoneNumber) async {
    var querySnapshot = await _firestore
        .collection('Users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> registration(String firstName, String lastName, String email,
      XFile profileImage) async {
    try {
      setRegisterLoading(true);
      String downloadUrl = await getLink(File(profileImage.path));
      Map<String, dynamic> userData = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": _auth.currentUser!.phoneNumber,
        "profileImage": downloadUrl
      };

      await _firestore.collection("Users").add(userData);
      setRegisterLoading(false);
      return true;
    } on FirebaseException catch (e) {
      log(e.code.toString());
      setRegisterLoading(false);
      return false;
    } catch (e) {
      log(e.toString());
      setRegisterLoading(false);
      return false;
    }
  }

  Future<void> logout() async {}

  Future<String> getLink(File profileImage) async {
    try {
      UploadTask uploadTask = _storage
          .ref()
          .child("ProfilePictures")
          .child(const Uuid().v1())
          .putFile(profileImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      log(e.code.toString());
      return "";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }
}

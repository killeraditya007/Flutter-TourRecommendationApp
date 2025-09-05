import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';
import 'package:tour_recommendation_app/utils/tours_details.dart';

class FirebaseUtils {

  static Future<void> createUserProfile(User? user, String username) async {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
      "name": username,
      "age": "",
      "phone": "",
      "gender": "",
      "email": user?.email,
      "favorites": [],
      "paymentMethods": [],
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  static Future<Map<String, dynamic>?> getUserDetails(String userUid) async {
    final response = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    return response.data();
  }

  static Future<void> cancelBooking(String bookingId, String uid)async{
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('bookings').doc(bookingId).update({
      'status':'Cancelled',
    });
  }

  static Future<Map<String, dynamic>?> getTourDetails(String tourId) async {
    final response = await FirebaseFirestore.instance.collection('tours').doc(tourId).get();
    return response.data();
  }

  static Future<void> saveUserDetails(String name, String gender, String phone, String age, String uid, context) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "name": name,
        "age": age,
        "phone": phone,
        "gender": gender,
      });
    } on FirebaseFirestore catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> addBooking(String userId, Map<String, dynamic> bookingData) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).collection('bookings').add(bookingData);
  }

  static Future<void> createUserWithEmailAndPassword(email, password, username, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      createUserProfile(FirebaseAuth.instance.currentUser, username);
      final user =  await getUserDetails(FirebaseAuth.instance.currentUser!.uid);
      UiUtils.showFlutterToast('Welcome, ${user?['name']}');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> loginUserWithEmailAndPassword(email, password, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );  
      final user =  await getUserDetails(FirebaseAuth.instance.currentUser!.uid);
      UiUtils.showFlutterToast('Welcome, ${user?['name']}');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    UiUtils.showFlutterToast('User logged out successfully');
  }

  static Future<void> saveTourDetails() async {
    for(int i=0;i<toursData.length;i++){
      await FirebaseFirestore.instance.collection("tours").add(toursData[i]);
    }
  }

  static Future<List<Map<String, dynamic>>> getBookingsData(String userUid)async{
    final response = await FirebaseFirestore.instance.collection("users").doc(userUid).collection("bookings").get();
    return response.docs.map((doc) => doc.data()).toList();
  }

  static Future<List<Map<String, dynamic>>> getToursData() async{
    final response = await FirebaseFirestore.instance.collection("tours").get();
    
    return  response.docs.map((doc) => {
        "tourId": doc.id,       // keep docId here
        ...doc.data(),      // spread the map
      }
    ).toList();
    // return response.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
        await user.delete();
        UiUtils.showFlutterToast('User deleted successfully');
      } else {
        UiUtils.showFlutterToast('No user signed in');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        UiUtils.showFlutterToast('The user must reauthenticate before deleting.');
      } else {
        UiUtils.showFlutterToast('Error Occured: ${e.message}');
      }
    }
  }

}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_recommendation_app/services/reusable_components.dart';
import 'package:tour_recommendation_app/utils/tours_details.dart';

/// 🔹 UI Utils
class UiUtils {
  /// Reusable Snackbar
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static String generateRandomIds(String method) {
    final random = Random();
    String number = random.nextInt(100000).toString().padLeft(6, '0');
    if(method == "Booking"){
      return "#BK$number";
    }else if(method == "TXN"){
      return "#TXN$number";
    }
    return "";
  }

  /// Reusable Loading Indicator
  static Widget loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        padding: EdgeInsets.only(top: 100),
      ),
    );
  }

  /// Reusable Button
  static Widget customButton({
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.blue,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  static List<Map<String, dynamic>> filterToursByCategory(selectedCategory){
    return toursData.where((tour) {
      final List<dynamic> categories = tour['categories']; 
      categories.contains(selectedCategory);
      return categories.contains(selectedCategory);
    }).toList();
  }

  static Future<void> showAlertDialog(BuildContext context, {alertHeading = 'Alert', alertMessage = 'Are you sure?', buttonText1 = 'No', buttonText2 = 'Yes', bookingId = '', uid = '', VoidCallback? onConfirm,}) async {
    print('calling dialog method');
    return showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertHeading),
          content: Text(alertMessage),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // align buttons to right
              children: [
                SizedBox(
                  height: 40,
                  width: 60,
                  child: TextButton(
                    child: Text(buttonText1, style: TextStyle(color: Colors.black),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                    child: Text(buttonText2, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if(alertHeading=='Logout Account'){
                        await FirebaseUtils.signOut();
                      }else if(alertHeading=='Delete Account'){
                        await FirebaseUtils.deleteUser();
                      }else if(alertHeading=='Cancel Tour'){
                        await FirebaseUtils.cancelBooking(bookingId, uid);
                        onConfirm!();
                      }else{
                        print('Invalid call....');
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );    
  }

  static String getAvatar(String? gender) {
    if (gender == null || gender.isEmpty) return 'assets/images/avatar.jpg';
    if (gender.toLowerCase() == 'male') return 'assets/images/avatar_male.jpg';
    return 'assets/images/avatar_female.jpg';
  }

  
  static void showFlutterToast(message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

}
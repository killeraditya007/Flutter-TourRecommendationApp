import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {

  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Map<String, dynamic>>> getBookingsWithTours(String uid) async {
    final bookingsSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('bookings').get();

    final bookings = bookingsSnapshot.docs;
    // fetch all tours in parallel
    final toursFutures = bookings.map((doc) async {
      
      final bookingData = doc.data();
      final tourId = bookingData['tour'];
      bookingData['bookingId'] = doc.id;
      final tourDoc = await FirebaseFirestore.instance.collection('tours').doc(tourId).get();
      bookingData['tour'] = tourDoc.data();
      return bookingData;
    });

    return Future.wait(toursFutures);
  }

  void cancelBooking(String bookingId)async{
    UiUtils.showAlertDialog(context, alertHeading: 'Cancel Tour', alertMessage: 'Are you sure you want to cancel the tour?', bookingId: bookingId, uid: uid);
    setState(() {
      getBookingsWithTours(uid);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Flexible(
              child: FutureBuilder(
                future: getBookingsWithTours(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return UiUtils.loadingIndicator();
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 250,),
                          Padding(
                            padding: EdgeInsets.only(left: 20,right: 20),
                            child: Text(
                              "No Bookings",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "Book Tour to check your bookings here.",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                  final bookingsWithTours = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: bookingsWithTours.length,
                    itemBuilder: (context, index) {
                      final booking = bookingsWithTours[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(
                                'assets/images/${booking['tour']['imageUrl']}',
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          booking['tour']['title'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: booking["status"] == "Upcoming"
                                              ? Colors.blue.shade100
                                              : booking["status"] == "Completed"
                                                  ? Colors.green.shade100
                                                  : Colors.red.shade100,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          booking["status"],
                                          style: TextStyle(
                                            color: booking["status"] == "Upcoming"
                                                ? Colors.blue
                                                : booking["status"] == "Completed"
                                                    ? Colors.green
                                                    : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.date_range, size: 16),
                                      SizedBox(width: 6),
                                      Text(
                                        "${DateFormat('MMMM d').format((booking['tourDetails']['tripDate']['startDate'] as Timestamp).toDate())} - "
                                        "${DateFormat('MMMM d, yyyy').format((booking['tourDetails']['tripDate']['endDate'] as Timestamp).toDate())}"
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.group, size: 16),
                                      SizedBox(width: 6),
                                      Text("${(booking['tourDetails']['travelers']['adult']+booking['tourDetails']['travelers']['children']).toString()} ${((booking['tourDetails']['travelers']['adult']+booking['tourDetails']['travelers']['children']) > 1)?"Travelers":"Traveler"}"),
                                    ],
                                  ),
                                  // SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(Icons.confirmation_num, size: 16),
                                      SizedBox(width: 6),
                                      Text("Booking ${booking['paymentDetails']['bookingId']}"),
                                      Spacer(),
                                      SizedBox(
                                        height: 40,
                                        width: 150,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue
                                          ),
                                          onPressed: () {
                                            _showBookingDetails(context, booking);
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("View Details", 
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 5),
                                              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white,),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ]
        )
      )
    );
  }

  void _showBookingDetails(BuildContext context, Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  booking['tour']['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text("Booking ID: ${booking['paymentDetails']["bookingId"]}"),
                SizedBox(height: 8),
                Text("Travel Date: ${DateFormat('MMMM d').format((booking['tourDetails']['tripDate']['startDate'] as Timestamp).toDate())}"),
                SizedBox(height: 8),
                Text("Travelers: ${booking['tourDetails']["travelers"]}"),
                Divider(height: 20),
                Text(
                  "Payment Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Txn ID"),
                      Text(booking['paymentDetails']['txnId'],
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Mode"),
                      Text(booking['paymentDetails']['mode'],
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount Paid"),
                      Text(booking['tourDetails']['total'].toString(),
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: booking['status']=='Upcoming'? () {
                    cancelBooking(booking['bookingId']);
                    Navigator.pop(context);
                  }:null,
                  child: Text("Cancel", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
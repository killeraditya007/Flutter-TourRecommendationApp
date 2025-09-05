import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_recommendation_app/services/reusable_components.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';

class BookingSuccessScreen extends StatefulWidget {
  final dynamic bookingDetails;
  const BookingSuccessScreen(this.bookingDetails, {super.key});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  bool _isloading = true;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String title = "";
  String loc = "";

  void updateMyBookings()async{
    await FirebaseUtils.addBooking(uid, widget.bookingDetails);
  }

  @override
  void initState() {
    super.initState();
    UiUtils.showFlutterToast('Processing Payment...');
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        title = widget.bookingDetails['tour']['title'];
        loc = widget.bookingDetails['tour']['location'];
        widget.bookingDetails['tour'] = widget.bookingDetails['tour']['tourId'];
        widget.bookingDetails['paymentDetails']['bookingId'] = UiUtils.generateRandomIds('Booking');
        widget.bookingDetails['paymentDetails']['txnId'] = UiUtils.generateRandomIds('TXN');
        _isloading = false;
      });
      updateMyBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading? UiUtils.loadingIndicator() : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // ✅ Success Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Booking Successful!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Your adventure is confirmed!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // 📄 Booking Details Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.receipt_long, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            "Booking Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),

                      // Tour Name
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.orange),
                          SizedBox(width: 4),
                          Text(loc),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Dates
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("${DateFormat('MMMM d').format(widget.bookingDetails['tourDetails']['tripDate']['startDate'])} - ${DateFormat('MMMM d, yyyy').format(widget.bookingDetails['tourDetails']['tripDate']['endDate'])}"),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Travelers
                      Row(
                        children: [
                          Icon(Icons.people, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("${widget.bookingDetails['tourDetails']['travelers']['adult']} Adults, ${widget.bookingDetails['tourDetails']['travelers']['children']} Child"),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Booking ID
                      Row(
                        children: [
                          Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("Booking ID: ${widget.bookingDetails['paymentDetails']['bookingId']}"),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Txn ID
                      Row(
                        children: [
                          Icon(Icons.numbers, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("Txn ID: ${widget.bookingDetails['paymentDetails']['txnId']}"),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Total Paid
                      Row(
                        children: [
                          Icon(Icons.attach_money, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text(
                            "${widget.bookingDetails['tourDetails']['total']}",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ✅ Payment Status
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified, color: Colors.green),
                            SizedBox(width: 6),
                            Text(
                              "Payment Completed",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Just now",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 📝 What's Next Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 6),
                          Text(
                            "What's Next",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text("1. Check your email for a detailed confirmation"),
                      SizedBox(height: 6),
                      Text("2. Review your itinerary in the 'My Bookings' section"),
                      SizedBox(height: 6),
                      Text("3. Pack your bags and get ready for adventure!"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🎯 Bottom Actions
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  "Back to Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

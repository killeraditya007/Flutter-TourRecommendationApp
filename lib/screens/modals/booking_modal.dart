import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tour_recommendation_app/screens/payment_selection.dart';

class BookingModal extends StatefulWidget {
  final dynamic tour;
  const BookingModal(this.tour, {super.key});

  @override
  State<BookingModal> createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  DateTimeRange? selectedDates;
  int adults = 1;
  int children = 0;
  late dynamic bookingDetails;
  late dynamic tour;
  TextEditingController specialRequestsController = TextEditingController();
  late double adultPrice;
  late double childPrice=0;
  late double tourPrice = 0;
  late double taxes;
  late double total;
  late int bookingFee;
  late int days;
  Color selectDate = Colors.grey.shade400;

  @override
  void initState() {
    super.initState();
    tour = widget.tour;
    adultPrice = widget.tour['price'].toDouble();
    childPrice = adultPrice/2;
    tourPrice = adultPrice.toDouble();
    taxes = tourPrice * 18 / 100;
    total = tourPrice + taxes + 49;
    bookingFee = 49;
    days = widget.tour['itinerary'].length;
  }

  void createBookingDetails(){
    setState(() {
      bookingDetails = {
        'bookingId': "",
        'status': 'Upcoming',
        'tour': tour,
        'tourDetails': {
          'tourPrice': tourPrice,
          'taxes': taxes,
          'total': total,
          'tripDate': {
            'startDate': selectedDates!.start,
            'endDate': selectedDates!.end
          },
          'travelers': {
            'adult': adults,
            'children': children
          },
        },
        'paymentDetails': {
          'mode': "",
          'bookingId': "",
          'txnId': "",
        },
      };
    });
  }

  void calculateTotalPrice(){
    setState(() {
      tourPrice = (adults * adultPrice) + (children * childPrice);
      taxes = tourPrice * 18 / 100;
      total = tourPrice + taxes + bookingFee;
    });
    
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      int difference = picked.end.difference(picked.start).inDays;

      if (difference > days) {
        Fluttertoast.showToast(
          msg: "Please select a range of maximum $days days.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        setState(() {
          selectedDates = picked;
          selectDate = Colors.grey.shade400;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Travel Dates
            Text("Travel Dates", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickDateRange,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: selectDate),
                  borderRadius: BorderRadius.circular(10),
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Text(
                      selectedDates == null
                          ? "Select Dates"
                          : "${DateFormat('MMMM d').format(selectedDates!.start)} - "
                            "${DateFormat('MMMM d, yyyy').format(selectedDates!.end)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today_outlined, color: Colors.blue),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Number of Travelers
            Text("Number of Travelers", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Adults", style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (adults > 1){
                          setState(() { 
                            adults--;
                            calculateTotalPrice();
                          });
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(adults.toString(), style: const TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: () => setState(() { 
                        adults++;
                        calculateTotalPrice();
                      }),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Children", style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (children > 0){
                          setState(() { 
                            children--;
                            calculateTotalPrice();
                          });
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(children.toString(), style: const TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: () => setState(() { 
                        children++;
                        calculateTotalPrice();
                      }),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 20),
             /// Price Summary
              const Text("Price Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildPriceRow("Tour Price (${adults.toString()} adults, ${children.toString()} children)", "₹${tourPrice.toString()}"),
              _buildPriceRow("Taxes & Fees", "₹${taxes.toString()}"),
              _buildPriceRow("Booking Fee", "₹${bookingFee.toString()}"),
              const Divider(),
              _buildPriceRow("Total", "₹${total.toStringAsFixed(2)}", isTotal: true),
              const SizedBox(height: 20),

            // Proceed to Payment
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDates != null){
                    createBookingDetails();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(bookingDetails)));
                  }else{
                    Fluttertoast.showToast(
                      msg: "Please select dates",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                    setState(() {
                      selectDate = Colors.red.shade400;
                    });
                  }
                  
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal
            )
          ),
          Text(price,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.blue : Colors.black
            )
          ),
        ],
      ),
    );
  }
}

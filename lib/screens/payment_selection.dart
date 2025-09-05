import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/screens/booking_success.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';

class PaymentScreen extends StatefulWidget {
  final dynamic bookingDetails;
  const PaymentScreen(this.bookingDetails, {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPayment = "card";
  bool _isloading = true;
  Map<String,dynamic> tour = {};

  void updateBookingDetails(){
    setState(() {
      widget.bookingDetails['paymentDetails']['mode'] = 'UPI';
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: _isloading? UiUtils.loadingIndicator() : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Tour Summary ----------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  "${widget.bookingDetails['tour']['title']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${widget.bookingDetails['tourDetails']['travelers']['adult']} Adults, ${widget.bookingDetails['tourDetails']['travelers']['children']} Child"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("₹${widget.bookingDetails['tourDetails']['tourPrice']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("Total",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ---------- Payment Method ----------
            const Text("Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            _buildPaymentOption("card", Icons.credit_card, "Credit/Debit Card"),
            _buildPaymentOption("upi", Icons.account_balance_wallet, "UPI"),
            _buildPaymentOption("netbanking", Icons.account_balance, "Net Banking"),
            _buildPaymentOption("cod", Icons.money, "Cash on Delivery"),

            const SizedBox(height: 16),

            // ---------- Dynamic Providers ----------
            _buildPaymentProviders(),

            const SizedBox(height: 20),

            // ---------- Price Details ----------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PriceRow("Tour Package (${widget.bookingDetails['tourDetails']['travelers']['adult']} Adults, ${widget.bookingDetails['tourDetails']['travelers']['children']} Child)", "₹${widget.bookingDetails['tourDetails']['tourPrice']}"),
                    _PriceRow("Taxes & Fees", "₹${widget.bookingDetails['tourDetails']['taxes']}"),
                    _PriceRow("Booking Fee", "₹49"),
                    Divider(),
                    _PriceRow("Total Amount", "₹${widget.bookingDetails['tourDetails']['total']}", isBold: true),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- Confirm Payment Button ----------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  updateBookingDetails();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingSuccessScreen(widget.bookingDetails)));
                },
                icon: const Icon(Icons.lock, color: Colors.white,),
                label: const Text("Confirm Payment", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String value, IconData icon, String label) {
    return Card(
      child: RadioListTile(
        value: value,
        groupValue: _selectedPayment,
        onChanged: (val) {
          setState(() {
            _selectedPayment = val.toString();
          });
        },
        title: Text(label),
        secondary: Icon(icon, color: Colors.blue),
      ),
    );
  }

  Widget _buildPaymentProviders() {
    switch (_selectedPayment) {
      case "card":
        return _buildCardDetails();
      case "upi":
        return _buildUPIOptions();
      case "netbanking":
        return _buildBankOptions();
      case "cod":
        return const Text("Pay at hotel check-in",
            style: TextStyle(fontSize: 14, color: Colors.grey));
      default:
        return Container();
    }
  }

  Widget _buildCardDetails() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Card Number"),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Expiry Date"),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "CVV"),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Card Holder Name"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUPIOptions() {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text("Google Pay"),
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text("PhonePe"),
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text("Paytm"),
        ),
      ],
    );
  }

  Widget _buildBankOptions() {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.account_balance),
          title: Text("HDFC Bank"),
        ),
        ListTile(
          leading: Icon(Icons.account_balance),
          title: Text("ICICI Bank"),
        ),
        ListTile(
          leading: Icon(Icons.account_balance),
          title: Text("SBI Bank"),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _PriceRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
        ],
      ),
    );
  }
}

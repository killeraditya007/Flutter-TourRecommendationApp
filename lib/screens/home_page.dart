import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/screens/tour_details_screen.dart';
import 'package:tour_recommendation_app/services/reusable_components.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';
import 'package:tour_recommendation_app/utils/tours_details.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  
  bool isloading = true;
  String categoryChecked = 'Default';
  List<Map<String, dynamic>> categorisedTours = [];

  Future<void> getData() async{
    final response = await FirebaseUtils.getToursData();
    setState(() {
      toursData = response;
      categorisedTours = toursData;
      isloading = false;
    });
  }

  Future<void> getUserDetails() async{
    final userDetails_ = await FirebaseUtils.getUserDetails(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userDetails = userDetails_!;
    });
  }

  @override
  void initState(){
    super.initState();
    getUserDetails();
    if(toursData.isEmpty){
       getData();
    }else{
      setState(() {
        categorisedTours = toursData;
        isloading=false;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Greetings...!", style: TextStyle(color: Colors.grey)),
                        Text("${userDetails['name'] ?? ''}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              child: Image.asset(UiUtils.getAvatar(userDetails['gender'])),
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(UiUtils.getAvatar(userDetails['gender'])),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Text("See all",
                    //     style: TextStyle(color: Colors.blue, fontSize: 14)),
                  ],
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories.map((category) {
                      return categoryItem(category['icon'],category['category'],category['color']);
                    }).toList(),
                  )
                ),
                SizedBox(height: 10),
                Text(
                  "All Tours",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: isloading? UiUtils.loadingIndicator() : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: (categorisedTours.isEmpty)?[SizedBox(height: 50,), Center(child: Text("No tours are available with this category"))]:categorisedTours.map((tour) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: tourCard(tour),
                      );
                    }).toList(),
                  )
                ),
              ]
            ),
          ),
        )
      )
    );
  }
  Widget categoryItem(IconData icon, String label, Color bgColor) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            categoryChecked=label;
            if(label!='Default'){
              categorisedTours=UiUtils.filterToursByCategory(label);
              
            }else{
              categorisedTours=toursData;
            }
          });

        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 24, // outer avatar radius (border)
              backgroundColor: (label==categoryChecked)? Colors.black:Colors.transparent, // border color
              child: CircleAvatar( 
                backgroundColor: bgColor,
                radius: 22,
                child: Icon(icon, size: 28, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: (label==categoryChecked)?FontWeight.bold:FontWeight.normal), ),
          ],
        ),
      ),
    );
  }

  Widget tourCard(tourData) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset('assets/images/${tourData['imageUrl']}',
                    height: 160, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${tourData["discount"]}% OFF",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${tourData["itinerary"].length.toString()} ${(tourData["itinerary"].length > 1)?"Days":"Day"}',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(tourData["title"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 16, color: Colors.orangeAccent),
                        const SizedBox(width: 4),
                        Text(tourData["rating"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 2),
                Text(tourData["location"],
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "₹${tourData["price"].toString()}",
                        style: TextStyle(
                          fontSize: 16,  // bigger size for price
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: " /person",
                        style: TextStyle(
                          fontSize: 14,  // smaller size
                          color: Colors.grey, // grey color
                        ),
                      ),
                    ],
                  ),
                ),
            
                SizedBox(
                  width: 120,
                  height: 40, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TourDetailsScreen(tourData)));
                    },
                    child: const Text("Book Now", style: TextStyle( color: Colors.white ,fontWeight: FontWeight.bold),),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }

}
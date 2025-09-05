import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/screens/tour_details_screen.dart';
import 'package:tour_recommendation_app/services/reusable_components.dart';
import 'package:tour_recommendation_app/utils/reusable_components.dart';
import 'package:tour_recommendation_app/utils/tours_details.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Favorite Tours"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 12),
            if(userDetails['favorites'].length < 1) 
              const Center(
                child: Column(
                  children: [
                    SizedBox(height: 250,),
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Text(
                        "No Favorite Tours Added",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "To Add Favorite Tour Click on ♡ icon.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

            if(userDetails['favorites'].length > 0) 
              Flexible(
                child: ListView.builder(
                  itemCount: userDetails['favorites'].length,
                  itemBuilder: (context, index) {
                    final tourID = userDetails['favorites'][index] ;
                    return FutureBuilder(
                      future: FirebaseFirestore.instance.collection("tours").doc(tourID).get(),
                      builder: (context, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return UiUtils.loadingIndicator();
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Text("Tour not found");
                        }
                        final tour = {
                          "tourId": snapshot.data!.id,       // include docId
                          ...snapshot.data!.data() as Map<String, dynamic>, // spread the map
                        };
                        // final tour = snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Container(
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
                                      child: Image.asset('assets/images/${tour['imageUrl']}',
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
                                          "${tour["discount"]}% OFF",
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
                                        child: Text('${tour["itinerary"].length.toString()} ${(tour["itinerary"].length > 1)?"Days":"Day"}',
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
                                            child: Text(tour["title"],
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
                                              Text(tour["rating"].toString(),
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
                                      Text(tour["location"],
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
                                              text: "₹${tour["price"].toString()}",
                                              style: TextStyle(
                                                fontSize: 16, 
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
                                          onPressed: () async {
                                            await Navigator.push(context, MaterialPageRoute(builder: (context) => TourDetailsScreen(tour)));
                                            setState(() {
                                              getUserDetails();
                                            });
                                          },
                                          child: const Text("Book Now", style: TextStyle( color: Colors.white ,fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
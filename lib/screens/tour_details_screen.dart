import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/screens/modals/booking_modal.dart';

class TourDetailsScreen extends StatefulWidget {
  final dynamic tourData;
  const TourDetailsScreen(this.tourData, {super.key});

  @override
  State<TourDetailsScreen> createState() => _TourDetailsScreenState();
}

class _TourDetailsScreenState extends State<TourDetailsScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  bool isFavorite = false;
  late dynamic tour;
  
  @override
  void initState() {
    super.initState();
    tour = widget.tourData;
    checkFavorite();
  }

  void checkFavorite()async{
    final res = await FirebaseFirestore.instance.collection("users").doc(userId).get();
    List<dynamic> favList = res.data()?['favorites'];
    setState(() {
       favList.contains(tour['tourId'])?isFavorite = true:isFavorite=false;
    });
  }

  Future<void> toggleWishlist(String tourID) async {

    await FirebaseFirestore.instance.collection("users").doc(userId).update({
      "favorites": FieldValue.arrayUnion([tourID]),

    });

    if (isFavorite) {
      // remove from wishlist
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "favorites": FieldValue.arrayUnion([tourID]),
      });
    } else {
      // add to wishlist
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "favorites": FieldValue.arrayRemove([tourID]),
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/${tour['imageUrl']}',
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite? Icons.favorite : Icons.favorite_border,
                  color: isFavorite? Colors.red : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  toggleWishlist(tour['tourId']);
                },
              ),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tour Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          tour['title'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 8),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 18, color: Colors.grey),
                        Text(
                          tour['location'],
                          style: TextStyle(
                            color: Colors.grey
                          )
                        ),
                        Spacer(),
                        Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text("${tour['itinerary'].length} days"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text("Categories: ",style: TextStyle(fontWeight: FontWeight.bold)),
                      ...tour['categories'].map<Widget>((category) {
                        return Text("$category, ");
                      }),
                    ]
                  ),
                  const SizedBox(height: 4),
                  // TabBar
                  DefaultTabController(
                    length: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blue,
                          isScrollable: false,
                          tabs: [
                            Tab(text: "Overview"),
                            Tab(text: "Highlights"),
                            Tab(text: "Itinerary"),
                            Tab(text: "Reviews"),
                          ],
                        ),
                        SizedBox(
                          height: 330,
                          child: TabBarView(
                            children: [
                              // Overview
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(8),
                                child: Text(tour['overview'],
                                  style: TextStyle(fontSize: 15),
                                  softWrap: true,
                                ),
                              ),
                              
                              // Highlights
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Highlights",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    ...tour['highlights'].map<Widget>((highlight) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blue.shade50,
                                          child: const Icon(Icons.beach_access, color: Colors.blue),
                                        ),
                                        title: Text(
                                          highlight,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: const Text(
                                          "Visit the most beautiful beaches including Kuta, Nusa Dua, and hidden gems.",
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              // Itinerary
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Itinerary",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: 280,
                                      width: 350,
                                      child: ListView.builder(
                                        itemCount: tour['itinerary'].length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor: Colors.blue,
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  if (index != tour['itinerary'].length - 1)
                                                    Container(
                                                      height: 40,
                                                      width: 2,
                                                      color: Colors.grey.shade400,
                                                    ),
                                                ]
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 90,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 250,
                                                      child: Text(
                                                        tour['itinerary'][index],
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    SizedBox(
                                                      width: 250,
                                                      child: Text(
                                                        "Itinerary description need to fill here.",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black87,
                                                        ),
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            ]
                                          );
                                        }   
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              // Reviews
                              SingleChildScrollView(
                                // padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Reviews",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                tour['rating'].toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                              const SizedBox(width: 4),
                                              Row(
                                                children: List.generate(
                                                  5,
                                                  (index) => const Icon(Icons.star,
                                                      size: 16, color: Colors.orange),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 280,
                                      child: ListView.builder(
                                        itemCount: tour['reviews'].length,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        itemBuilder: (context, index) {
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            margin: const EdgeInsets.symmetric(vertical: 8),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: tour['reviews'][index]['imageUrl']==null?NetworkImage("https://randomuser.me/api/portraits/women/17.jpg"):NetworkImage(tour['reviews'][index]['imageUrl']),
                                                        radius: 20,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              tour['reviews'][index]['user'],
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              "June 2023",
                                                              style: const TextStyle(
                                                                  fontSize: 12, color: Colors.grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: List.generate(
                                                          tour['reviews'][index]['stars'],
                                                          (index) => const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ]
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Text(
                                                   tour['reviews'][index]['comment'],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ]
                                              )
                                            )
                                          );
                                        }
                                      )
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "₹${tour["price"].toString()}",
                                style: TextStyle(
                                  fontSize: 20,  // bigger size for price
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: " /person",
                                style: TextStyle(
                                  fontSize: 12,  // smaller size
                                  color: Colors.grey, // grey color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedSuperellipseBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => BookingModal(tour),
                        );
                      },
                      child: const Text(
                        "Book Now",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/tour_details_screen.dart';
import 'package:tour_recommendation_app/tours_details.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        isSearching = _searchController.text.isNotEmpty;
      });
    });
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
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
                        Text("Good morning", style: TextStyle(color: Colors.grey)),
                        Text("Hi, Emma!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    GestureDetector(
                      onDoubleTap: (){
                        _signOut(context);
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      hintText: "Search destinations, tours...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
      
                if (isSearching) _buildSearchResults(),
      
                if (!isSearching) _buildHomeContent(),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: bgColor,
            radius: 22,
            child: Icon(icon, size: 28, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.filter_list),
                label: Text("Filter"),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.sort),
                label: Text("Sort"),
              ),
            ),
            Text("${toursData.length} results", style: TextStyle(color: Colors.grey)),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Categories",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("See all",
                style: TextStyle(color: Colors.blue, fontSize: 14)),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Popular Tours",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("See all",
                style: TextStyle(color: Colors.blue, fontSize: 14)),
          ],
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: toursData.map((tour) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                child: tourCard(tour),
              );
            }).toList(),
          )
        ),
        // SizedBox(
        //   height: 455,
        //   child: ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     itemCount: toursData.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
        //         child: tourCard(toursData[index]),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget tourCard(tour) {
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
                child: Image.asset('assets/images/${tour['imageUrl']}',
                    height: 160, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                right: 10,
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
              )
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
                          fontSize: 22,  // bigger size for price
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TourDetailsScreen(tour)));
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
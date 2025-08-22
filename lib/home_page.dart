import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/tour_details_screen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  final List<String> categories = ["Adventure", "Historical", "Beach", "Family", "Cultural"];
  final List<Map<String, dynamic>> tourData = [
  {
    "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    "title": "Maldives Paradise",
    "location": "Maldives",
    "price": "\$799",
    "rating": 4.8,
    "tag": "HOT DEAL",
  },
  {
    "imageUrl": "https://tse1.mm.bing.net/th/id/OIP.hZXvMERKcVGl8fQzrjXRHAHaEo?rs=1&pid=ImgDetMain&o=7&rm=3",
    "title": "Swiss Alps Adventure",
    "location": "Switzerland",
    "price": "\$999",
    "rating": 4.9,
    "tag": "TRENDING",
  },
  {
    "imageUrl": "https://images.unsplash.com/photo-1518684079-3c830dcef090",
    "title": "Tokyo City Lights",
    "location": "Tokyo, Japan",
    "price": "\$599",
    "rating": 4.7,
    "tag": "POPULAR",
  },
  {
    "imageUrl": "https://tse1.mm.bing.net/th/id/OIP.yWbQAE-g_8BdVbUNY7HxiQHaEK?rs=1&pid=ImgDetMain&o=7&rm=3",
    "title": "Bali Beach Escape",
    "location": "Bali, Indonesia",
    "price": "\$499",
    "rating": 4.6,
    "tag": "TRENDING",
  },
  {
    "imageUrl": "https://images.unsplash.com/photo-1505761671935-60b3a7427bad",
    "title": "Paris Romance",
    "location": "Paris, France",
    "price": "\$699",
    "rating": 4.9,
    "tag": "HOT",
  },
  {
    "imageUrl": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
    "title": "New York Explorer",
    "location": "New York, USA",
    "price": "\$649",
    "rating": 4.5,
    "tag": "POPULAR",
  },
  {
    "imageUrl": "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05",
    "title": "Dubai Luxury Tour",
    "location": "Dubai, UAE",
    "price": "\$899",
    "rating": 4.7,
    "tag": "LUXURY",
  },
  {
    "imageUrl": "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    "title": "Santorini Getaway",
    "location": "Santorini, Greece",
    "price": "\$499",
    "rating": 4.9,
    "tag": "TRENDING",
  },
  {
    "imageUrl": "https://th.bing.com/th/id/R.e36a89e2628ed8608c86280f83e726c5?rik=hVQUmkQU7Tzxpg&riu=http%3a%2f%2f10wallpaper.com%2fwallpaper%2f1920x1080%2f1209%2flondon_panorama-European_Landscape_Wallpaper_1920x1080.jpg&ehk=W%2b91WZk713L8Q5lvzZtFLlaqgHk5Dur0odq0VeVrtNY%3d&risl=&pid=ImgRaw&r=0",
    "title": "London Classic",
    "location": "London, UK",
    "price": "\$579",
    "rating": 4.4,
    "tag": "POPULAR",
  },
  {
    "imageUrl": "https://4kwallpapers.com/images/walls/thumbs_3t/23615.jpg",
    "title": "Sydney Opera Tour",
    "location": "Sydney, Australia",
    "price": "\$729",
    "rating": 4.6,
    "tag": "TRENDING",
  },
];


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
        
                /// Top Bar
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
                SizedBox(height: 16),
        
                /// Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search destinations, tours...",
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                /// If user is searching → show Search Results
                if (isSearching) _buildSearchResults(),

                /// Else show Default Home Screen
                if (!isSearching) _buildHomeContent(),
              ]
            ),
          ),
        )
      )
    );
  }
  Widget categoryItem(IconData icon, String label, Color bgColor) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: bgColor,
          radius: 28,
          child: Icon(icon, size: 28, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
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
            Spacer(),
            Text("${tourData.length} results", style: TextStyle(color: Colors.grey)),
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
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            categoryItem(Icons.terrain, "Adventure", Colors.blue[100]!),
            categoryItem(Icons.account_balance, "Historical", Colors.amber[100]!),
            categoryItem(Icons.beach_access, "Beach", Colors.teal[100]!),
            categoryItem(Icons.family_restroom, "Family", Colors.green[100]!),
          ],
        ),
        const SizedBox(height: 20),

        /// Popular Tours
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
        const SizedBox(height: 12),
        SizedBox(
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: tourData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
                child: tourCard(tourData[index]),
              );
            },
          ),
        )
      ],
    );
  }

  Widget tourCard(tour) {
    return Container(
      height: 270,
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
                child: Image.network(tour["imageUrl"],
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
                    tour["tag"],
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
                    Text(tour["title"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
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
                        text: tour["price"],
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TourDetailsScreen(tour: tour)));
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
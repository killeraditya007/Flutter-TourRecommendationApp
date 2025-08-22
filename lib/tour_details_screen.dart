import 'package:flutter/material.dart';

class TourDetailsScreen extends StatefulWidget {
  final dynamic tour;
  const TourDetailsScreen({super.key, required this.tour});

  @override
  State<TourDetailsScreen> createState() => _TourDetailsScreenState();
}

class _TourDetailsScreenState extends State<TourDetailsScreen> {
  bool isFavorite = false;
  late dynamic tour;

  final List<Map<String, String>> itinerary = [
    {
      "day": "Day 1: Arrival & Welcome",
      "details": "Airport pickup, check-in at luxury resort, welcome dinner on the beach."
    },
    {
      "day": "Day 2: Ubud Exploration",
      "details": "Visit Monkey Forest, Ubud Palace, and local art markets."
    },
    {
      "day": "Day 3: Temple Tour",
      "details": "Visit Tanah Lot, Uluwatu Temple, and enjoy a traditional Kecak dance."
    },
    {
      "day": "Day 4: Beach Day",
      "details": "Relax at Nusa Dua beach, water activities, seafood dinner.",
    },
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Sarah Johnson",
      "date": "June 2023",
      "rating": 5,
      "review":
          "This tour exceeded all my expectations! The guides were knowledgeable and friendly. The beaches were pristine and the cultural experiences were authentic.",
      "imageUrl":
          "https://randomuser.me/api/portraits/women/44.jpg",
    },
    {
      "name": "Michael Chen",
      "date": "May 2023",
      "rating": 4,
      "review":
          "Great experience overall. The volcano trek was challenging but worth it for the sunrise views. The only downside was that some days felt a bit rushed.",
      "imageUrl":
          "https://randomuser.me/api/portraits/men/32.jpg",
    },
  ];

  
  @override
  void initState() {
    super.initState();
    tour = widget.tour;
  }

  @override
  Widget build(BuildContext context) {
    print(tour['rating']);
    print(4<tour['rating']);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Book Now",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                tour['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
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
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        tour['price'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(tour['location'],
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index+1 < tour['rating']
                            ? Icons.star
                            : Icons.star_half, // 4.5 rating
                        color: Colors.orange,
                        size: 20,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),

                  // Info Row
                  Row(
                    children: const [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("7 days"),
                      SizedBox(width: 16),
                      Icon(Icons.people, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("Max 12 people"),
                      SizedBox(width: 16),
                      Icon(Icons.language, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("English, Spanish"),
                    ],
                  ),
                  const SizedBox(height: 20),

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
                          height: 250,
                          child: TabBarView(
                            children: [
                              // Overview
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(8),
                                child: const Text(
                                  "Experience the ultimate tropical getaway with our Bali Paradise Tour. "
                                  "This 7-day adventure takes you through the most stunning locations in Bali, "
                                  "from pristine beaches to lush rice terraces and ancient temples. "
                                  "You'll enjoy luxury accommodations, authentic local cuisine, and unforgettable cultural experiences.",
                                  style: TextStyle(fontSize: 15),
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

                                    // Highlight Item 1
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue.shade50,
                                        child: const Icon(Icons.beach_access, color: Colors.blue),
                                      ),
                                      title: const Text(
                                        "Pristine Beaches",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Text(
                                        "Visit the most beautiful beaches including Kuta, Nusa Dua, and hidden gems.",
                                      ),
                                    ),

                                    // Highlight Item 2
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue.shade50,
                                        child: const Icon(Icons.terrain, color: Colors.blue),
                                      ),
                                      title: const Text(
                                        "Volcano Trekking",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Text(
                                        "Sunrise trek to Mount Batur with breathtaking panoramic views.",
                                      ),
                                    ),

                                    // Highlight Item 3
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue.shade50,
                                        child: const Icon(Icons.temple_buddhist, color: Colors.blue),
                                      ),
                                      title: const Text(
                                        "Cultural Immersion",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Text(
                                        "Visit ancient temples and participate in traditional Balinese ceremonies.",
                                      ),
                                    ),

                                    // Highlight Item 4
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue.shade50,
                                        child: const Icon(Icons.restaurant, color: Colors.blue),
                                      ),
                                      title: const Text(
                                        "Culinary Delights",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: const Text(
                                        "Cooking classes and tasting authentic Balinese cuisine at local restaurants.",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Itinerary
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Itinerary",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: itinerary.length,
                                        itemBuilder: (context, index) {
                                          final item = itinerary[index];
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 14,
                                                    backgroundColor: index == itinerary.length - 1
                                                      ? Colors.grey.shade300
                                                      : Colors.blue,
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: index == itinerary.length - 1
                                                            ? Colors.grey
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  if (index != itinerary.length - 1)
                                                    Container(
                                                      height: 40,
                                                      width: 2,
                                                      color: Colors.grey.shade400,
                                                    ),
                                                ]
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 70,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item["day"]!,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: index == itinerary.length - 1
                                                            ? Colors.grey
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      item["details"]!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: index == itinerary.length - 1
                                                            ? Colors.grey
                                                            : Colors.black87,
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
                                    GestureDetector(
                                      onTap: () {
                                        // Action for "View full itinerary"
                                      },
                                      child: Text(
                                        "View full itinerary ➜",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Reviews
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Reviews",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "4.5",
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
                                    SizedBox(height: 10,),
                                    SizedBox(
                                      height: 400,
                                      child: ListView.builder(
                                        itemCount: reviews.length,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        itemBuilder: (context, index) {
                                          final review = reviews[index];
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
                                                        backgroundImage: NetworkImage(review['imageUrl']),
                                                        radius: 20,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              review['name'],
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            Text(
                                                              review['date'],
                                                              style: const TextStyle(
                                                                  fontSize: 12, color: Colors.grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: List.generate(
                                                          review['rating'],
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
                                                   review['review'],
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
                  const SizedBox(height: 80), // For space above Book Now btn
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


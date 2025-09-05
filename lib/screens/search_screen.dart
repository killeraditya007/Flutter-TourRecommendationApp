import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/screens/tour_details_screen.dart';
import 'package:tour_recommendation_app/utils/tours_details.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

enum SortOption { popularity, priceLowHigh, priceHighLow, az, za }

class _ExploreScreenState extends State<ExploreScreen> {
  SortOption _selectedSort = SortOption.popularity;

  List<Map<String, dynamic>> sortedTours = [];

  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  
  @override
  void initState() {
    super.initState();
    sortedTours = List.from(toursData);
    _applySorting();
  }

  void _openSortModal() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Sort By",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),

                  RadioGroup<SortOption>(
                    groupValue: _selectedSort,
                    onChanged: (SortOption? value) {
                      setModalState(() => _selectedSort = value!);
                      setState(() => _selectedSort = value!);
                      Navigator.pop(context);
                      _applySorting();
                    },
                    child: Column(
                      children: [
                        ...[{"label": "Popularity", "value": SortOption.popularity},
                            {"label": "Price - Low to High", "value": SortOption.priceLowHigh},
                            {"label": "Price - High to Low", "value": SortOption.priceHighLow},
                            {"label": "A - Z", "value": SortOption.az},
                            {"label": "Z - A", "value": SortOption.za},
                          ].map((option) {
                            return ListTile(
                              title: Text(option["label"] as String),
                              leading: Radio<SortOption>(value: option["value"] as SortOption)
                            );
                          }
                        ),
                      ],
                    )
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _applySorting() {
    setState(() {
      switch (_selectedSort) {
        case SortOption.popularity:
          sortedTours.sort((a, b) =>
              (b["rating"] as double).compareTo(a["rating"] as double));
          break;
        case SortOption.priceLowHigh:
          sortedTours.sort(
              (a, b) => (a["price"] as int).compareTo(b["price"] as int));
          break;
        case SortOption.priceHighLow:
          sortedTours.sort(
              (a, b) => (b["price"] as int).compareTo(a["price"] as int));
          break;
        case SortOption.az:
          sortedTours
              .sort((a, b) => (a["title"] as String).compareTo(b["title"]));
          break;
        case SortOption.za:
          sortedTours
              .sort((a, b) => (b["title"] as String).compareTo(a["title"]));
          break;
      }
    });
  }

  List<Map<String,dynamic>> filterSearchResult( String query) {
    return toursData.where((tour) {
      final lowerQuery = query.toLowerCase();
      return tour['title'].toLowerCase().contains(lowerQuery) ||
          tour['location'].toLowerCase().contains(lowerQuery);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Explore Tours"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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
                    onChanged: (value){
                      if(value.isNotEmpty){
                        setState(() {
                          sortedTours = filterSearchResult(value);
                        });
                      }
                      else{
                        setState(() {
                          sortedTours = List.from(toursData);
                          _applySorting();
                        });
                      }
                    },
                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  backgroundColor: Colors.white,
                  label: Text("Sort"),
                  onSelected: (_) {
                    _openSortModal();
                  },
                  avatar: Icon(Icons.sort, size: 18),
                ),
                Text("${sortedTours.length} results",
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                itemCount: sortedTours.length,
                itemBuilder: (context, index) {
                  final tour = sortedTours[index];
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
                      ),
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


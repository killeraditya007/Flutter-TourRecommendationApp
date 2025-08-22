import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/favourite_screen.dart';
import 'package:tour_recommendation_app/home_page.dart';
import 'package:tour_recommendation_app/profile_screen.dart';
import 'package:tour_recommendation_app/search_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int selectedTab = 0;
  List<Widget> listOfScreens = [
    MyHomePage(),
    SearchScreen(),
    FavouriteScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Likes",
            tooltip: "Likes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
            tooltip: "Account",
          ),
        ],
      ),
      body: listOfScreens[selectedTab],
    );
  }
}

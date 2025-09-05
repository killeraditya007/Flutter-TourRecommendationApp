import 'package:flutter/material.dart';
import 'package:tour_recommendation_app/screens/home_page.dart';
import 'package:tour_recommendation_app/screens/my_bookings.dart';
import 'package:tour_recommendation_app/screens/profile_screen.dart';
import 'package:tour_recommendation_app/screens/search_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int selectedTab = 0;
  List<Widget> listOfScreens = [
    MyHomePage(),
    ExploreScreen(),
    MyBookingsScreen(),
    AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
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
            label: "Explore",
            tooltip: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.luggage),
            label: "Bookings",
            tooltip: "Bookings",
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

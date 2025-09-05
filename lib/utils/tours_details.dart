import 'package:flutter/material.dart';

List<Map<String, dynamic>> toursData = [];

Map<String,dynamic> userDetails = {};

List<Map<String, dynamic>> myBookings = [];

List<Map<String,dynamic>> categories = [
  {
    "category": "Default",
    "icon": Icons.grid_view,
    "color": Colors.grey[100]
  },
  {
    "category": "Adventure",
    "icon": Icons.terrain,
    "color": Colors.blue[100]
  },
  {
    "category": "Historical",
    "icon": Icons.account_balance,
    "color": Colors.amber[100]
  },
  {
    "category": "Beach",
    "icon": Icons.beach_access,
    "color": Colors.teal[100]
  },
  {
    "category": "Family",
    "icon": Icons.family_restroom,
    "color": Colors.green[100]
  },
  {
    "category": "Cultural",
    "icon": Icons.terrain,
    "color": Colors.blue[100]
  },
  {
    "category": "Solo",
    "icon": Icons.boy,
    "color": Colors.amber[100]
  },
  {
    "category": "Trek",
    "icon": Icons.terrain,
    "color": Colors.teal[100]
  },
  {
    "category": "Nature",
    "icon": Icons.landscape,
    "color": Colors.green[100]
  },
  {
    "category": "Spiritual",
    "icon": Icons.temple_hindu,
    "color": Colors.amber[100]
  },
  {
    "category": "Couple",
    "icon": Icons.wc,
    "color": Colors.blue[100]
  },

];

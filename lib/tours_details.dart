import 'package:flutter/material.dart';

List<Map<String, dynamic>> toursData = [
  {
    "id": 1,
    "imageUrl": "Kerala_Backwaters_Retreat_Alleppey.png",
    "title": "Kerala Backwaters Retreat - Alleppey",
    "location": "Alappuzha, Kerala",
    "price": 13999,
    "rating": 4.6,
    "discount": 12,
    "reviews": [
      {"user": "Ankit Sharma", "comment": "Houseboat was spotless and views were serene.", "stars": 5, "imageUrl": "https://randomuser.me/api/portraits/men/72.jpg"},
      {"user": "Neha Iyer", "comment": "Calm vibe, perfect for a slow holiday.", "stars": 5, "imageUrl": "https://randomuser.me/api/portraits/women/44.jpg"},
      {"user": "Rohit Menon", "comment": "Food onboard was tasty but a bit spicy.", "stars": 4, "imageUrl": "https://randomuser.me/api/portraits/men/76.jpg"},
      {"user": "Pooja Desai", "comment": "Sunset cruise was a dream!", "stars": 5, "imageUrl": "https://randomuser.me/api/portraits/women/44.jpg"},
      {"user": "Kunal Arora", "comment": "Check-in took longer than expected.", "stars": 3, "imageUrl": "https://randomuser.me/api/portraits/women/44.jpg"},
      {"user": "Divya Nair", "comment": "Village walk felt authentic and warm.", "stars": 5, "imageUrl": "https://randomuser.me/api/portraits/women/44.jpg"},
      {"user": "Aakash Verma", "comment": "Mosquitoes at night—carry repellent.", "stars": 3, "imageUrl": "https://randomuser.me/api/portraits/women/44.jpg"},
      {"user": "Simran Bhatia", "comment": "Peaceful, scenic, and relaxing.", "stars": 5, "imageUrl": "https://randomuser.me/api/portraits/women/17.jpg"}
    ],
    "itinerary": [
      "Day 1: Arrival in Alleppey & houseboat check-in",
      "Day 2: Backwaters cruise, village walk & sunset on Vembanad",
      "Day 3: Breakfast onboard & checkout"
    ],
    "overview":
        "Unwind on a private houseboat through Alleppey’s emerald canals. Enjoy backwater sunsets, traditional Kerala meals, and slow-living moments that recharge the soul.",
    "highlights": [
      "Private houseboat cruise",
      "Vembanad Lake sunset",
      "Traditional Kerala cuisine"
    ],
    "categories": ["Backwaters", "Relaxation", "Houseboat"]
  },
  {
    "id": 2,
    "imageUrl": "leh_ladakh_highaltitude_road_trip.png",
    "title": "Leh–Ladakh High-Altitude Road Trip",
    "location": "Leh, Ladakh",
    "price": 27999,
    "rating": 4.5,
    "discount": 8,
    "reviews": [
      {"user": "Priyanka Kaul", "comment": "Pangong Lake view was surreal.", "stars": 5},
      {"user": "Amit Khanna", "comment": "Well-organized routes and stays.", "stars": 5},
      {"user": "Sana Raza", "comment": "Altitude hit hard—plan acclimatization.", "stars": 3},
      {"user": "Vivek Sood", "comment": "Khardung La felt epic!", "stars": 5},
      {"user": "Harsh Gupta", "comment": "Roads are rough in patches.", "stars": 4},
      {"user": "Meera Kapoor", "comment": "Guides were supportive and informed.", "stars": 5},
      {"user": "Sahil Arora", "comment": "Food options limited in Nubra.", "stars": 3},
      {"user": "Ritika Malhotra", "comment": "Starry skies like nowhere else.", "stars": 5}
    ],
    "itinerary": [
      "Day 1: Arrive Leh & acclimatization",
      "Day 2: Sham Valley & monasteries",
      "Day 3: Nubra Valley via Khardung La",
      "Day 4: Pangong Lake & night stay",
      "Day 5: Return to Leh & departure"
    ],
    "overview":
        "A bucket-list Himalayan drive across high passes, lunar landscapes, and turquoise lakes. Balanced acclimatization, reliable support crew, and unforgettable vistas.",
    "highlights": [
      "Khardung La Pass",
      "Nubra Valley sand dunes",
      "Pangong Tso sunrise"
    ],
    "categories": ["Mountains", "Road Trip", "Adventure"]
  },
  {
    "id": 3,
    "imageUrl": "rishikesh_yoga_rafting_escape.png",
    "title": "Rishikesh Yoga & Rafting Escape",
    "location": "Rishikesh, Uttarakhand",
    "price": 7999,
    "rating": 4.3,
    "discount": 10,
    "reviews": [
      {"user": "Arun Tiwari", "comment": "Morning yoga by the Ganga was bliss.", "stars": 5},
      {"user": "Kavita Joshi", "comment": "Rafting was safe and thrilling.", "stars": 5},
      {"user": "Deep Mehta", "comment": "Rooms a bit basic but clean.", "stars": 3},
      {"user": "Sonia Gill", "comment": "Ganga Aarti was soul-stirring.", "stars": 5},
      {"user": "Naman Shah", "comment": "Café scene is great, service slow.", "stars": 4},
      {"user": "Rhea Kapoor", "comment": "Beatles Ashram was unique.", "stars": 4},
      {"user": "Kunal Sinha", "comment": "Wish rafting stretch was longer.", "stars": 3},
      {"user": "Tanya Bhosale", "comment": "Felt refreshed and energized.", "stars": 5}
    ],
    "itinerary": [
      "Day 1: Arrival, yoga session & Ganga Aarti",
      "Day 2: White-water rafting & café hopping",
      "Day 3: Beatles Ashram visit & departure"
    ],
    "overview":
        "Balance adrenaline and mindfulness with guided yoga by the Ganga, safe white-water rafting, and soulful evenings at the ghats.",
    "highlights": [
      "Sunrise yoga by the river",
      "White-water rafting",
      "Triveni Ghat Aarti"
    ],
    "categories": ["Spiritual", "Adventure", "River"]
  },
  {
    "id": 4,
    "imageUrl": "udaipur_lakes_palaces.png",
    "title": "Udaipur Lakes & Palaces",
    "location": "Udaipur, Rajasthan",
    "price": 11999,
    "rating": 4.6,
    "discount": 15,
    "reviews": [
      {"user": "Rahul Mahajan", "comment": "Boat ride at sunset was dreamy.", "stars": 5},
      {"user": "Ishita Parekh", "comment": "City Palace tour was detailed.", "stars": 5},
      {"user": "Parth Trivedi", "comment": "Traffic near old city gets heavy.", "stars": 3},
      {"user": "Seema Chakraborty", "comment": "Great boutique hotel picks.", "stars": 4},
      {"user": "Aditya Bansal", "comment": "Monsoon Palace views are vast.", "stars": 5},
      {"user": "Nidhi Kapoor", "comment": "Food scene is fantastic.", "stars": 4},
      {"user": "Rohan Rai", "comment": "Wanted more cultural shows.", "stars": 3},
      {"user": "Ananya Ghosh", "comment": "Romantic and elegant vibe.", "stars": 5}
    ],
    "itinerary": [
      "Day 1: City Palace & Old City walk",
      "Day 2: Lake Pichola boat ride & Haveli visit",
      "Day 3: Sajjangarh (Monsoon Palace) & markets"
    ],
    "overview":
        "The ‘City of Lakes’ charms with palatial architecture, serene boat rides, and candlelit dinners by the water—perfect for couples and culture lovers.",
    "highlights": [
      "City Palace & museums",
      "Lake Pichola sunset cruise",
      "Sajjangarh viewpoint"
    ],
    "categories": ["Heritage", "Luxury", "Couple"]
  },
  {
    "id": 5,
    "imageUrl": "Jaisalmer_Thar_Desert_Safari.png",
    "title": "Jaisalmer Thar Desert Safari",
    "location": "Jaisalmer, Rajasthan",
    "price": 10999,
    "rating": 4.2,
    "discount": 10,
    "reviews": [
      {"user": "Mehul Deshmukh", "comment": "Camel safari at sunset was iconic.", "stars": 5},
      {"user": "Ritika Jain", "comment": "Folk music night was memorable.", "stars": 4},
      {"user": "Zaid Khan", "comment": "Tents comfy but nights get cold.", "stars": 3},
      {"user": "Harleen Kaur", "comment": "Golden Fort is stunning.", "stars": 5},
      {"user": "Pratik Patel", "comment": "Meals could be hotter.", "stars": 3},
      {"user": "Shruti Saxena", "comment": "Jeep safari added excitement.", "stars": 4},
      {"user": "Devendra Solanki", "comment": "Clear starry sky—wow!", "stars": 5},
      {"user": "Asha Bedi", "comment": "Market haggling is tiring.", "stars": 3}
    ],
    "itinerary": [
      "Day 1: Jaisalmer Fort & havelis",
      "Day 2: Sam Sand Dunes camel & jeep safari",
      "Day 3: Folk performance & desert camp"
    ],
    "overview":
        "Live the desert dream with shimmering dunes, folk rhythms by a bonfire, and golden sandstone architecture that brings Rajasthan’s heritage alive.",
    "highlights": [
      "Sam Sand Dunes safari",
      "Jaisalmer Fort & havelis",
      "Stargazing in the desert"
    ],
    "categories": ["Desert", "Culture", "Adventure"]
  },
  {
    "id": 6,
    "imageUrl": "Munnar_Tea_Trails_Waterfalls.png",
    "title": "Munnar Tea Trails & Waterfalls",
    "location": "Munnar, Kerala",
    "price": 10499,
    "rating": 4.4,
    "discount": 9,
    "reviews": [
      {"user": "Kiran Pillai", "comment": "Tea estate walk was refreshing.", "stars": 5},
      {"user": "Tanvi Kulkarni", "comment": "Eravikulam park was a highlight.", "stars": 4},
      {"user": "Sagar Patil", "comment": "Rains can disrupt plans—carry gear.", "stars": 3},
      {"user": "Ipsita Roy", "comment": "Waterfalls were in full flow.", "stars": 5},
      {"user": "Mahesh Rao", "comment": "Tea museum was informative.", "stars": 4},
      {"user": "Roshni Dutta", "comment": "Some roads are narrow.", "stars": 3},
      {"user": "Vaibhav Nair", "comment": "Cool weather, scenic views.", "stars": 5},
      {"user": "Aarti Menon", "comment": "Great value for money.", "stars": 4}
    ],
    "itinerary": [
      "Day 1: Tea museum & estate walk",
      "Day 2: Eravikulam National Park",
      "Day 3: Attukal waterfalls & local markets"
    ],
    "overview":
        "Rolling tea gardens, misty mornings, and gushing falls—Munnar is a gentle mountain escape with nature walks and aromatic brews.",
    "highlights": [
      "Tea estate & museum",
      "Eravikulam National Park",
      "Attukal waterfalls"
    ],
    "categories": ["Mountains", "Tea Gardens", "Nature"]
  },
  {
    "id": 7,
    "imageUrl": "Darjeeling_Himalayan_Escape.png",
    "title": "Darjeeling Himalayan Escape",
    "location": "Darjeeling, West Bengal",
    "price": 11499,
    "rating": 4.3,
    "discount": 10,
    "reviews": [
      {"user": "Soham Chatterjee", "comment": "Tiger Hill sunrise was golden.", "stars": 5},
      {"user": "Riya Bhattacharya", "comment": "Toy train ride is nostalgic.", "stars": 5},
      {"user": "Abhay Kapoor", "comment": "Fog hid Kanchenjunga one day.", "stars": 3},
      {"user": "Mona Sen", "comment": "Tea tastings were delightful.", "stars": 4},
      {"user": "Manav Kakkar", "comment": "Crowded during weekends.", "stars": 3},
      {"user": "Esha Ghosh", "comment": "Batasia Loop is picturesque.", "stars": 5},
      {"user": "Yash Agarwal", "comment": "Loved local momos!", "stars": 4},
      {"user": "Nikita Bose", "comment": "Charming hill town feels.", "stars": 4}
    ],
    "itinerary": [
      "Day 1: Himalayan Mountaineering Institute & zoo",
      "Day 2: Tiger Hill sunrise & Batasia Loop",
      "Day 3: Tea garden tour & toy train"
    ],
    "overview":
        "A classic hill-station getaway with vintage train rides, mountain sunrises, and fragrant tea gardens overlooking dramatic valleys.",
    "highlights": [
      "Tiger Hill sunrise",
      "Darjeeling Toy Train",
      "Batasia Loop gardens"
    ],
    "categories": ["Mountains", "Heritage", "Train"]
  },
  {
    "id": 8,
    "imageUrl": "Hampi_Ruins_Boulders.png",
    "title": "Hampi Ruins & Boulders",
    "location": "Hampi, Karnataka",
    "price": 9499,
    "rating": 4.4,
    "discount": 7,
    "reviews": [
      {"user": "Prerna Shetty", "comment": "Vittala Temple carvings blew my mind.", "stars": 5},
      {"user": "Ashwin Kulkarni", "comment": "Sunset at Matanga Hill = wow.", "stars": 5},
      {"user": "Girish Joshi", "comment": "Heat can be intense—go early.", "stars": 3},
      {"user": "Megha Salian", "comment": "Cycling through ruins was fun.", "stars": 4},
      {"user": "Lokesh Bhat", "comment": "Need more water points on routes.", "stars": 3},
      {"user": "Shreya Rao", "comment": "History comes alive here.", "stars": 5},
      {"user": "Advait Deshpande", "comment": "Cafés are chilled and artsy.", "stars": 4},
      {"user": "Rashmi Iyer", "comment": "Guide was knowledgeable.", "stars": 4}
    ],
    "itinerary": [
      "Day 1: Virupaksha Temple & bazaar",
      "Day 2: Vittala Temple & Stone Chariot",
      "Day 3: Matanga Hill trek & coracle ride"
    ],
    "overview":
        "UNESCO-listed ruins set among giant boulders—Hampi blends myth, architecture, and landscapes for photographers and history buffs alike.",
    "highlights": [
      "Vittala Temple & Stone Chariot",
      "Matanga Hill sunset",
      "Coracle ride on Tungabhadra"
    ],
    "categories": ["Historical", "UNESCO", "Trek"]
  },
  {
    "id": 9,
    "imageUrl": "Andaman_Havelock_Island_Beach_Break.png",
    "title": "Andaman Havelock Island Beach Break",
    "location": "Havelock Island, Andaman & Nicobar",
    "price": 23999,
    "rating": 4.6,
    "discount": 10,
    "reviews": [
      {"user": "Ayesha Noor", "comment": "Radhanagar Beach is pristine.", "stars": 5},
      {"user": "Parikshit Rao", "comment": "Snorkeling at Elephant Beach—amazing reefs.", "stars": 5},
      {"user": "Rupal Dave", "comment": "Ferry timings can be tricky.", "stars": 3},
      {"user": "Ketan Shah", "comment": "Scuba intro was safe and fun.", "stars": 5},
      {"user": "Shalini Mishra", "comment": "A bit pricey but worth it.", "stars": 4},
      {"user": "Imran Siddiqui", "comment": "Limited nightlife options.", "stars": 3},
      {"user": "Nidhi Gupta", "comment": "Clean beaches and warm water.", "stars": 5},
      {"user": "Ritesh Vora", "comment": "Loved the island vibe.", "stars": 4}
    ],
    "itinerary": [
      "Day 1: Port Blair to Havelock & beach time",
      "Day 2: Radhanagar Beach & sunset",
      "Day 3: Elephant Beach snorkel/scuba & return"
    ],
    "overview":
        "Powdery white sands, clear lagoons, and playful reefs—Havelock is your tropical postcard with safe snorkeling and optional scuba dives.",
    "highlights": [
      "Radhanagar Beach sunset",
      "Elephant Beach snorkeling",
      "Scuba dive intro"
    ],
    "categories": ["Beach", "Snorkeling", "Relaxation"]
  },
  {
    "id": 10,
    "imageUrl": "Coorg_Coffee _Waterfalls.png",
    "title": "Coorg Coffee & Waterfalls",
    "location": "Coorg, Karnataka",
    "price": 9999,
    "rating": 4.2,
    "discount": 11,
    "reviews": [
      {"user": "Varun Reddy", "comment": "Coffee estate tour smelled heavenly.", "stars": 5},
      {"user": "Shraddha Kulkarni", "comment": "Abbey Falls was roaring.", "stars": 4},
      {"user": "Rohini Nair", "comment": "Homestay was cozy but remote.", "stars": 3},
      {"user": "Deepak Shekhar", "comment": "Dubare Elephant Camp was lovely.", "stars": 4},
      {"user": "Payal Gopal", "comment": "Rain added charm, carry ponchos.", "stars": 4},
      {"user": "Keshav Iyer", "comment": "Food was homely and fresh.", "stars": 5},
      {"user": "Muskan Shah", "comment": "Some roads are bumpy.", "stars": 3},
      {"user": "Akhil Rao", "comment": "Greenery everywhere—so soothing.", "stars": 5}
    ],
    "itinerary": [
      "Day 1: Coffee estate walk & tasting",
      "Day 2: Abbey Falls & Raja’s Seat",
      "Day 3: Dubare Elephant Camp & local markets"
    ],
    "overview":
        "Mist-laden hills, aromatic coffee trails, and gentle waterfalls—Coorg serves a restful hill holiday with estate stays and nature strolls.",
    "highlights": [
      "Estate coffee tasting",
      "Abbey Falls viewpoint",
      "Dubare Elephant interactions"
    ],
    "categories": ["Hills", "Coffee", "Nature"]
  },
  {
    "id": 11,
    "imageUrl": "Rishikesh_Adventure_Yoga.png",
    "title": "Rishikesh Adventure & Yoga",
    "location": "Rishikesh, Uttarakhand",
    "price": 8999,
    "rating": 4.6,
    "discount": 12,
    "reviews": [
      {"user": "Kunal Sharma", "comment": "River rafting was thrilling!", "stars": 5},
      {"user": "Megha Bhatia", "comment": "Peaceful yoga retreat.", "stars": 4},
      {"user": "Vivek Menon", "comment": "Hotels could improve.", "stars": 3},
      {"user": "Sneha Iyer", "comment": "Perfect balance of adventure and spirituality.", "stars": 5},
      {"user": "Arjun Deshmukh", "comment": "Crowded during peak season.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Arrival & evening Ganga Aarti",
      "Day 2: River rafting & cliff jumping",
      "Day 3: Yoga retreat & local sightseeing"
    ],
    "overview":
        "Discover the spiritual and adventurous side of Rishikesh with yoga, meditation, and thrilling water sports on the Ganges.",
    "highlights": [
      "River rafting",
      "Yoga sessions",
      "Evening Ganga Aarti"
    ],
    "categories": ["Adventure", "Spiritual", "Nature"]
  },
  {
    "id": 12,
    "imageUrl": "Kerala_Backwaters_Escape.png",
    "title": "Kerala Backwaters Escape",
    "location": "Alleppey, Kerala",
    "price": 14999,
    "rating": 4.7,
    "discount": 8,
    "reviews": [
      {"user": "Ananya Nair", "comment": "Houseboat stay was magical!", "stars": 5},
      {"user": "Rahul Varma", "comment": "Very relaxing atmosphere.", "stars": 4},
      {"user": "Priya Nambiar", "comment": "Food was delicious and authentic.", "stars": 5},
      {"user": "Ramesh Pillai", "comment": "Could use better transport options.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Arrival & houseboat cruise",
      "Day 2: Backwater exploration",
      "Day 3: Visit to local villages & coir factories"
    ],
    "overview":
        "Sail through the serene Kerala backwaters in a traditional houseboat while experiencing authentic cuisine and village life.",
    "highlights": [
      "Houseboat cruise",
      "Backwater canals",
      "Village life experience"
    ],
    "categories": ["Nature", "Relaxation", "Culture"]
  },
  {
    "id": 13,
    "imageUrl": "Royal_Heritage_of_Mysore.png",
    "title": "Royal Heritage of Mysore",
    "location": "Mysore, Karnataka",
    "price": 10999,
    "rating": 4.4,
    "discount": 15,
    "reviews": [
      {"user": "Karthik Reddy", "comment": "Palace is stunning!", "stars": 5},
      {"user": "Pooja Shetty", "comment": "Chamundi Hills view is breathtaking.", "stars": 4},
      {"user": "Naveen Rao", "comment": "Traffic can be an issue.", "stars": 3},
      {"user": "Shreya Prakash", "comment": "Loved the cultural richness.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Arrival & Mysore Palace tour",
      "Day 2: Visit Chamundi Hills & Brindavan Gardens",
      "Day 3: Explore local silk & sandalwood markets"
    ],
    "overview":
        "Explore the grandeur of Mysore with its palaces, temples, and royal traditions that reflect Karnataka’s rich culture.",
    "highlights": [
      "Mysore Palace",
      "Brindavan Gardens",
      "Chamundi Hills"
    ],
    "categories": ["Heritage", "Culture", "Family"]
  },
  {
    "id": 14,
    "imageUrl": "Darjeeling_Tea_Hills.png",
    "title": "Darjeeling Tea & Hills",
    "location": "Darjeeling, West Bengal",
    "price": 13499,
    "rating": 4.6,
    "discount": 10,
    "reviews": [
      {"user": "Arpita Ghosh", "comment": "Toy train ride was nostalgic.", "stars": 5},
      {"user": "Sourav Banerjee", "comment": "Tea gardens are scenic.", "stars": 4},
      {"user": "Nikhil Chatterjee", "comment": "Cold weather adds charm.", "stars": 5},
      {"user": "Debjani Roy", "comment": "Hotels were average.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Arrival & tea garden visit",
      "Day 2: Toy train ride & Tiger Hill sunrise",
      "Day 3: Explore local monasteries"
    ],
    "overview":
        "Sip world-famous Darjeeling tea, enjoy Himalayan views, and experience the colonial-era charm of the hill station.",
    "highlights": [
      "Tiger Hill sunrise",
      "Darjeeling Himalayan Railway",
      "Tea gardens"
    ],
    "categories": ["Nature", "Heritage", "Relaxation"]
  },
  {
    "id": 15,
    "imageUrl": "Udaipur_City_of_Lakes.png",
    "title": "Udaipur City of Lakes",
    "location": "Udaipur, Rajasthan",
    "price": 15999,
    "rating": 4.8,
    "discount": 5,
    "reviews": [
      {"user": "Rajat Singh", "comment": "City Palace was majestic.", "stars": 5},
      {"user": "Divya Rathore", "comment": "Lake Pichola sunset was dreamy.", "stars": 5},
      {"user": "Harshvardhan Chauhan", "comment": "Boat ride was memorable.", "stars": 4},
      {"user": "Simran Kaur", "comment": "Bit expensive overall.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Arrival & City Palace tour",
      "Day 2: Lake Pichola boat ride & Jag Mandir visit",
      "Day 3: Explore Saheliyon Ki Bari & local markets"
    ],
    "overview":
        "Known as the Venice of the East, Udaipur enchants with its palaces, lakes, and royal hospitality.",
    "highlights": [
      "City Palace",
      "Lake Pichola",
      "Jag Mandir"
    ],
    "categories": ["Heritage", "Luxury", "Romantic"]
  },
  {
    "id": 16,
    "imageUrl": "Kedarnath_Spiritual_Trek.png",
    "title": "Kedarnath Spiritual Trek",
    "location": "Kedarnath, Uttarakhand",
    "price": 17999,
    "rating": 4.7,
    "discount": 10,
    "reviews": [
      {"user": "Aman Pandey", "comment": "Spiritual and breathtaking trek.", "stars": 5},
      {"user": "Sunita Rawat", "comment": "Tiring but worth it.", "stars": 4},
      {"user": "Prakash Joshi", "comment": "Weather can be challenging.", "stars": 3},
      {"user": "Neha Chauhan", "comment": "Darshan was peaceful.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Arrival & acclimatization",
      "Day 2: Trek to Kedarnath",
      "Day 3: Temple darshan & return"
    ],
    "overview":
        "Embark on a spiritual trek to Kedarnath, one of the holiest shrines of Lord Shiva nestled in the Himalayas.",
    "highlights": [
      "Kedarnath Temple",
      "Scenic trekking route",
      "Himalayan views"
    ],
    "categories": ["Spiritual", "Adventure", "Nature"]
  },
  {
    "id": 17,
    "imageUrl": "Andaman_Island_Paradise.png",
    "title": "Andaman Island Paradise",
    "location": "Port Blair, Andaman & Nicobar",
    "price": 24999,
    "rating": 4.9,
    "discount": 7,
    "reviews": [
      {"user": "Ravi Iyer", "comment": "Pristine beaches and crystal water.", "stars": 5},
      {"user": "Sanjana Rao", "comment": "Scuba diving was mind-blowing.", "stars": 5},
      {"user": "Abhishek Nair", "comment": "Little expensive but worth it.", "stars": 4},
      {"user": "Tanvi Dutta", "comment": "Peaceful and scenic.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Arrival & Cellular Jail visit",
      "Day 2: Havelock Island & scuba diving",
      "Day 3: Radhanagar Beach & local exploration"
    ],
    "overview":
        "Experience pristine beaches, adventure water sports, and island life in the tropical Andaman paradise.",
    "highlights": [
      "Radhanagar Beach",
      "Scuba diving",
      "Cellular Jail"
    ],
    "categories": ["Beach", "Adventure", "Relaxation"]
  },
  {
    "id": 18,
    "imageUrl": "Leh_Ladakh_Road_Trip.png",
    "title": "Leh-Ladakh Road Trip",
    "location": "Leh-Ladakh, Jammu & Kashmir",
    "price": 29999,
    "rating": 4.8,
    "discount": 12,
    "reviews": [
      {"user": "Vikram Kaul", "comment": "Pangong Lake was surreal.", "stars": 5},
      {"user": "Deepa Sharma", "comment": "Road trip was thrilling.", "stars": 5},
      {"user": "Aditya Bhat", "comment": "Food options limited.", "stars": 3},
      {"user": "Monika Thakur", "comment": "Monasteries were peaceful.", "stars": 4},
    ],
    "itinerary": [
      "Day 1: Arrival & Leh city tour",
      "Day 2: Drive to Nubra Valley",
      "Day 3: Pangong Lake visit"
    ],
    "overview":
        "A once-in-a-lifetime Himalayan road trip through high mountain passes, monasteries, and breathtaking landscapes.",
    "highlights": [
      "Pangong Lake",
      "Nubra Valley",
      "Khardung La Pass"
    ],
    "categories": ["Adventure", "Nature", "Road Trip"]
  },
  {
    "id": 19,
    "imageUrl": "Rann_of_Kutch_Festival.png",
    "title": "Rann of Kutch Festival",
    "location": "Kutch, Gujarat",
    "price": 13999,
    "rating": 4.6,
    "discount": 15,
    "reviews": [
      {"user": "Hardik Patel", "comment": "White desert looks magical under moonlight.", "stars": 5},
      {"user": "Shalini Trivedi", "comment": "Cultural performances were vibrant.", "stars": 4},
      {"user": "Nirav Desai", "comment": "Accommodation was average.", "stars": 3},
      {"user": "Pallavi Joshi", "comment": "Loved the folk dance and music.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Arrival & tent stay",
      "Day 2: White desert exploration & cultural festival",
      "Day 3: Visit Kala Dungar & local villages"
    ],
    "overview":
        "Witness the cultural extravaganza of Gujarat amidst the surreal beauty of the white desert in Kutch.",
    "highlights": [
      "White desert",
      "Cultural festival",
      "Kala Dungar"
    ],
    "categories": ["Culture", "Festival", "Nature"]
  },
  {
    "id": 20,
    "imageUrl": "Shillong_Meghalaya_Wonders.png",
    "title": "Shillong & Meghalaya Wonders",
    "location": "Shillong, Meghalaya",
    "price": 16999,
    "rating": 4.7,
    "discount": 10,
    "reviews": [
      {"user": "Rohan Dey", "comment": "Waterfalls were stunning.", "stars": 5},
      {"user": "Ankita Sen", "comment": "Mawsynram rains were unique.", "stars": 4},
      {"user": "Debashish Paul", "comment": "Some areas hard to access.", "stars": 3},
      {"user": "Soma Das", "comment": "Beautiful living root bridges.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Arrival & Shillong city tour",
      "Day 2: Visit Cherrapunji & Mawsynram",
      "Day 3: Explore living root bridges & waterfalls"
    ],
    "overview":
        "Explore the natural beauty of Meghalaya with its waterfalls, caves, and unique living root bridges.",
    "highlights": [
      "Living root bridges",
      "Cherrapunji",
      "Shillong city tour"
    ],
    "categories": ["Nature", "Adventure", "Culture"]
  },
  {
    "id": 21,
    "imageUrl": "Leh_Ladakh.png",
    "title": "Leh Ladakh Road Trip",
    "location": "Leh, Ladakh, India",
    "price": 24999,
    "rating": 4.8,
    "discount": 12,
    "reviews": [
      {"user": "Rahul Bhatia", "comment": "Breathtaking landscapes and thrilling adventure.", "stars": 5},
      {"user": "Sneha Reddy", "comment": "Challenging roads but worth every second.", "stars": 4},
      {"user": "Kunal Verma", "comment": "Bike trip of a lifetime!", "stars": 5},
      {"user": "Anushka Joshi", "comment": "Altitude sickness was tough.", "stars": 3},
      {"user": "Aditya Mehra", "comment": "Loved Pangong Lake.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Arrival in Leh",
      "Day 2: Nubra Valley via Khardung La",
      "Day 3: Pangong Lake excursion"
    ],
    "overview":
        "Embark on the ultimate road trip across rugged mountains, pristine lakes, and the highest motorable passes in the world.",
    "highlights": ["Khardung La Pass", "Pangong Lake", "Nubra Valley"],
    "categories": ["Adventure", "Road Trip", "Mountains"]
  },
  {
    "id": 22,
    "imageUrl": "Udaipur_Royal_Retreat.png",
    "title": "Udaipur Royal Retreat",
    "location": "Udaipur, Rajasthan, India",
    "price": 15999,
    "rating": 4.6,
    "discount": 8,
    "reviews": [
      {"user": "Meera Kapoor", "comment": "Truly a city of lakes.", "stars": 5},
      {"user": "Sanjay Sharma", "comment": "The palaces are enchanting.", "stars": 4},
      {"user": "Nikita Yadav", "comment": "Felt royal at the City Palace.", "stars": 5},
      {"user": "Arjun Rathore", "comment": "A bit crowded at tourist spots.", "stars": 3},
      {"user": "Shreya Iyer", "comment": "Loved the boat ride.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: City Palace & Jagdish Temple",
      "Day 2: Lake Pichola boat ride",
      "Day 3: Fateh Sagar Lake & local market"
    ],
    "overview":
        "Enjoy the regal charm of Udaipur, famous for its stunning palaces, shimmering lakes, and rich cultural heritage.",
    "highlights": ["City Palace", "Lake Pichola", "Saheliyon ki Bari"],
    "categories": ["Culture", "Heritage", "Romantic"]
  },
  {
    "id": 23,
    "imageUrl": "Munnar_Tea_Garden_Escape.png",
    "title": "Munnar Tea Garden Escape",
    "location": "Munnar, Kerala, India",
    "price": 10999,
    "rating": 4.4,
    "discount": 15,
    "reviews": [
      {"user": "Deepa Nair", "comment": "Green everywhere, so peaceful.", "stars": 5},
      {"user": "Arvind Menon", "comment": "Best place for relaxation.", "stars": 4},
      {"user": "Tanya Deshmukh", "comment": "Tea gardens are stunning.", "stars": 5},
      {"user": "Rohit Shetty", "comment": "Hotels were limited.", "stars": 3},
      {"user": "Kavya Singh", "comment": "Loved the weather.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Visit tea gardens",
      "Day 2: Eravikulam National Park",
      "Day 3: Mattupetty Dam & boating"
    ],
    "overview":
        "Soak in the beauty of sprawling tea plantations, misty hills, and the serene atmosphere of Munnar.",
    "highlights": ["Tea gardens", "Eravikulam Park", "Mattupetty Dam"],
    "categories": ["Nature", "Hill Station", "Relaxation"]
  },
  {
    "id": 24,
    "imageUrl": "Sundarbans_Wildlife_Safari.png",
    "title": "Sundarbans Wildlife Safari",
    "location": "West Bengal, India",
    "price": 13999,
    "rating": 4.3,
    "discount": 10,
    "reviews": [
      {"user": "Priya Banerjee", "comment": "Unique mangrove experience.", "stars": 5},
      {"user": "Rohit Bose", "comment": "Spotted crocodiles and birds.", "stars": 4},
      {"user": "Snehal Chakraborty", "comment": "Didn’t get to see a tiger.", "stars": 3},
      {"user": "Abhay Sen", "comment": "Boat ride was thrilling.", "stars": 5},
      {"user": "Nandini Ghosh", "comment": "Food could be better.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Arrival & river cruise",
      "Day 2: Forest safari by boat",
      "Day 3: Visit local villages"
    ],
    "overview":
        "Explore the mysterious mangroves of Sundarbans, home to the majestic Royal Bengal Tiger and exotic wildlife.",
    "highlights": ["Mangrove safari", "Royal Bengal Tiger", "Boat cruise"],
    "categories": ["Wildlife", "Nature", "Adventure"]
  },
  {
    "id": 25,
    "imageUrl": "Andaman_Island_Paradise2.png",
    "title": "Andaman Island Paradise",
    "location": "Andaman & Nicobar Islands, India",
    "price": 21999,
    "rating": 4.7,
    "discount": 14,
    "reviews": [
      {"user": "Karan Pillai", "comment": "Scuba diving was fantastic.", "stars": 5},
      {"user": "Pooja Rane", "comment": "Pristine beaches and waters.", "stars": 5},
      {"user": "Vivek Rao", "comment": "Connectivity was an issue.", "stars": 3},
      {"user": "Sonia D'Souza", "comment": "Radhanagar Beach is heaven.", "stars": 5},
      {"user": "Harsh Malhotra", "comment": "Felt a bit overpriced.", "stars": 4},
    ],
    "itinerary": [
      "Day 1: Cellular Jail & Corbyn's Cove",
      "Day 2: Scuba diving at Havelock",
      "Day 3: Radhanagar Beach"
    ],
    "overview":
        "Unwind on sun-kissed beaches, explore coral reefs, and indulge in adventure at the Andaman Islands.",
    "highlights": ["Scuba diving", "Radhanagar Beach", "Cellular Jail"],
    "categories": ["Beach", "Adventure", "Relaxation"]
  },
  {
    "id": 26,
    "imageUrl": "Varanasi_Spiritual_Sojourn.png",
    "title": "Varanasi Spiritual Sojourn",
    "location": "Varanasi, Uttar Pradesh, India",
    "price": 8999,
    "rating": 4.5,
    "discount": 10,
    "reviews": [
      {"user": "Anil Yadav", "comment": "Ganga Aarti is divine.", "stars": 5},
      {"user": "Megha Tripathi", "comment": "Truly a spiritual city.", "stars": 4},
      {"user": "Saurabh Dubey", "comment": "Crowded but worth it.", "stars": 3},
      {"user": "Kriti Mishra", "comment": "Boat ride at sunrise was surreal.", "stars": 5},
      {"user": "Pankaj Singh", "comment": "Streets are a bit messy.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Ganga Aarti at Dashashwamedh Ghat",
      "Day 2: Kashi Vishwanath Temple",
      "Day 3: Sarnath visit"
    ],
    "overview":
        "Immerse yourself in the spiritual aura of Varanasi, with its sacred ghats, temples, and cultural richness.",
    "highlights": ["Ganga Aarti", "Kashi Vishwanath", "Boat ride"],
    "categories": ["Spiritual", "Culture", "Heritage"]
  },
  {
    "id": 27,
    "imageUrl": "Jodhpur_Desert_Escape.png",
    "title": "Jodhpur Desert Escape",
    "location": "Jodhpur, Rajasthan, India",
    "price": 13999,
    "rating": 4.4,
    "discount": 12,
    "reviews": [
      {"user": "Simran Chawla", "comment": "Blue city is magical.", "stars": 5},
      {"user": "Rajeev Mehta", "comment": "Mehrangarh Fort is majestic.", "stars": 5},
      {"user": "Tara Kapoor", "comment": "Food was spicy but tasty.", "stars": 4},
      {"user": "Nitin Saxena", "comment": "Too hot in summer.", "stars": 3},
      {"user": "Shweta Jain", "comment": "Camel safari was fun.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Mehrangarh Fort & Jaswant Thada",
      "Day 2: Explore Blue City streets",
      "Day 3: Camel safari in desert"
    ],
    "overview":
        "Discover the desert charm of Jodhpur with grand forts, vibrant bazaars, and a stunning blue-washed old city.",
    "highlights": ["Mehrangarh Fort", "Blue City", "Camel Safari"],
    "categories": ["Culture", "Heritage", "Adventure"]
  },
  {
    "id": 28,
    "imageUrl": "Mahabalipuram_Heritage_Trail.png",
    "title": "Mahabalipuram Heritage Trail",
    "location": "Tamil Nadu, India",
    "price": 10999,
    "rating": 4.2,
    "discount": 9,
    "reviews": [
      {"user": "Arvind Krishnan", "comment": "Sculptures are breathtaking.", "stars": 5},
      {"user": "Ritu Menon", "comment": "A UNESCO heritage gem.", "stars": 5},
      {"user": "Mohan Kumar", "comment": "Bit hot during the day.", "stars": 3},
      {"user": "Ayesha Reddy", "comment": "Loved the shore temple.", "stars": 4},
      {"user": "Devika Nair", "comment": "Crowded on weekends.", "stars": 3},
    ],
    "itinerary": [
      "Day 1: Shore Temple & Arjuna’s Penance",
      "Day 2: Pancha Rathas",
      "Day 3: Local handicraft market"
    ],
    "overview":
        "Walk through the historic monuments and intricate rock-cut temples of Mahabalipuram, a UNESCO World Heritage site.",
    "highlights": ["Shore Temple", "Pancha Rathas", "Arjuna’s Penance"],
    "categories": ["Culture", "Heritage", "History"]
  },
  {
    "id": 29,
    "imageUrl": "ShillongHills_Adventure.png",
    "title": "Shillong Hills Adventure",
    "location": "Shillong, Meghalaya, India",
    "price": 14999,
    "rating": 4.6,
    "discount": 11,
    "reviews": [
      {"user": "Rekha Das", "comment": "Scotland of the East indeed.", "stars": 5},
      {"user": "Vikram Roy", "comment": "Beautiful waterfalls.", "stars": 4},
      {"user": "Mala Sen", "comment": "Loved the markets and music.", "stars": 5},
      {"user": "Anupam Choudhury", "comment": "Transport is limited.", "stars": 3},
      {"user": "Priyanka Paul", "comment": "So green and peaceful.", "stars": 5},
    ],
    "itinerary": [
      "Day 1: Umiam Lake visit",
      "Day 2: Elephant Falls & Shillong Peak",
      "Day 3: Local markets & music cafes"
    ],
    "overview":
        "Escape into the lush hills of Shillong, with stunning waterfalls, lively markets, and soulful music culture.",
    "highlights": ["Umiam Lake", "Elephant Falls", "Shillong Peak"],
    "categories": ["Nature", "Hill Station", "Culture"]
  },
  {
    "id": 30,
    "imageUrl": "Ellora_Ajanta_Heritage_Tour.png",
    "title": "Ellora & Ajanta Heritage Tour",
    "location": "Aurangabad, Maharashtra, India",
    "price": 12999,
    "rating": 4.5,
    "discount": 10,
    "reviews": [
      {"user": "Prakash Jadhav", "comment": "Unbelievable ancient art.", "stars": 5},
      {"user": "Maya Kulkarni", "comment": "Carvings are so detailed.", "stars": 5},
      {"user": "Arun Patil", "comment": "Need more time to explore.", "stars": 4},
      {"user": "Sheetal Deshpande", "comment": "Hot but worth it.", "stars": 3},
      {"user": "Vishal Pawar", "comment": "Guides were helpful.", "stars": 4},
    ],
    "itinerary": [
      "Day 1: Ellora Caves tour",
      "Day 2: Ajanta Caves excursion",
      "Day 3: Bibi ka Maqbara"
    ],
    "overview":
        "Witness the grandeur of Indian rock-cut architecture at Ajanta and Ellora, showcasing centuries of history and artistry.",
    "highlights": ["Ellora Caves", "Ajanta Caves", "Bibi ka Maqbara"],
    "categories": ["Culture", "Heritage", "History"]
  }
];

List<Map<String,dynamic>> categories = [
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






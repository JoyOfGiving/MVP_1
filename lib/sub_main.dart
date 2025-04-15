import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: "My Donation"),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: "Help"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Background
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'), // Add this asset in pubspec.yaml
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello, Test User", style: TextStyle(fontSize: 16, color: Colors.black54)),
                      SizedBox(height: 10),
                      Text(
                        "Let's make a difference today!",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 10),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for NGO...",
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            suffixIcon: Icon(Icons.filter_list, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Search NGOs by Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Search NGOs by Location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CityIcon(city: "Bangalore", icon: 'assets/bangalore.png'),
                CityIcon(city: "Mumbai", icon: 'assets/mumbai.png'),
                CityIcon(city: "Kerala", icon: 'assets/kerala.png'),
              ],
            ),

            SizedBox(height: 20),

            // Register for Campaigns
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Register for Campaigns",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            // Campaign Cards
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  CampaignCard(image: 'assets/campaign1.png', title: 'Warm Clothing Drive'),
                  CampaignCard(image: 'assets/campaign2.png', title: 'Food Distribution'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Campaign Card
/*class CampaignCard extends StatelessWidget {
  final String image;
  final String title;

  const CampaignCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(image, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("Feb 12, 2025 • 10:00 PM", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}
*/

Future<String> loadImage(String imagePath) async {
  await Future.delayed(Duration(milliseconds: 300)); // Simulate load time
  return imagePath;
}

class CampaignCard extends StatelessWidget {
  final String image;
  final String title;

  const CampaignCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadImage(image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return buildCard(snapshot.data!);
      },
    );
  }

  Widget buildCard(String imagePath) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(imagePath, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("Feb 12, 2025 • 10:00 PM", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}


// Widget for City Icon
class CityIcon extends StatelessWidget {
  final String city;
  final String icon;

  const CityIcon({super.key, required this.city, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(icon),
        ),
        SizedBox(height: 5),
        Text(city, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
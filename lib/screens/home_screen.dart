import 'package:flutter/material.dart';
import 'news_screen.dart';
import 'promo_screen.dart';
import 'class_search_screen.dart';
import 'class_screen.dart';
import '../data/class_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Akaratorn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 3),
            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.white70, size: 16),
                Text(
                  "เกตเวย์ บางซื่อ (MRT เตาปูน)",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.newspaper, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.local_offer, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PromoScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSearchScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickAction("คลาส", "จองออนไลน์", Icons.calendar_today, context),
                _buildQuickAction("คลับ", "เข้าได้ทุกคลับ", Icons.location_on, context),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("คลาสวันนี้", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSearchScreen()));
                  },
                  child: const Text("ทั้งหมด", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: classData.length,
                itemBuilder: (context, index) {
                  var c = classData[index];
                  return _buildClassCard(context, c["title"], c["category"], c["time"], c["imagePath"], c["spotsLeft"], c["totalSpots"], c["isFull"]);
                },
              ),
            ),
            const SizedBox(height: 20),

            _buildSection(context, "โปรโมชั่น", "ดูทั้งหมด", const PromoScreen(), [
              "assets/images/promo1.jpg",
              "assets/images/promo2.jpg",
              "assets/images/promo3.jpg"
            ]),

            _buildSection(context, "ข่าวสาร", "ดูทั้งหมด", const NewsScreen(), [
              "assets/images/news1.jpg",
              "assets/images/news2.jpg",
              "assets/images/news3.jpg"
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, String subtitle, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassSearchScreen()));
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1)],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.red),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, String title, String type, String time, String imagePath, String spotsLeft, String totalSpots, bool isFull) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassScreen(
              title: title,
              description: "$title is a fitness class focused on $type.",
              category: type,
              spotsLeft: spotsLeft,
              totalSpots: totalSpots,
              location: "เกตเวย์ บางซื่อ (MRT เตาปูน)",
              date: "11 มี.ค. 2568",
              time: time,
              instructor: "Hub",
              imagePath: imagePath,
              instructorImage: "assets/images/instructor_hub.jpg",
              isFull: isFull,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.asset(imagePath, height: 80, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(type, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.red),
                      const SizedBox(width: 5),
                      Text(time, style: const TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String actionText, Widget screen, List<String> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
              },
              child: Text(actionText, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'class_screen.dart';
import '../data/class_data.dart';

class ClassSearchScreen extends StatefulWidget {
  const ClassSearchScreen({super.key});

  @override
  _ClassSearchScreenState createState() => _ClassSearchScreenState();
}

class _ClassSearchScreenState extends State<ClassSearchScreen> {
  String searchQuery = "";
  List<Map<String, dynamic>> filteredClasses = classData;

  void _filterClasses(String query) {
    setState(() {
      searchQuery = query;
      filteredClasses = classData
          .where((c) => c["title"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("ค้นหาคลาส", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ✅ Add Search Bar
            TextField(
              onChanged: _filterClasses,
              decoration: InputDecoration(
                hintText: "ค้นหาชื่อคลาส...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Display Filtered Classes
            Expanded(
              child: filteredClasses.isEmpty
                  ? const Center(child: Text("ไม่พบคลาสที่ค้นหา", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: filteredClasses.length,
                      itemBuilder: (context, index) {
                        var c = filteredClasses[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.asset(c["imagePath"], width: 60, height: 60, fit: BoxFit.cover),
                            title: Text(c["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("${c["category"]} • ${c["time"]}"),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: c["isFull"] ? Colors.grey : Colors.green,
                              ),
                              onPressed: c["isFull"]
                                  ? null // Disable if full
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ClassScreen(
                                            title: c["title"],
                                            description: "${c["title"]} is a fitness class focused on ${c["category"]}.",
                                            category: c["category"],
                                            spotsLeft: c["spotsLeft"],
                                            totalSpots: c["totalSpots"],
                                            location: "เกตเวย์ บางซื่อ (MRT เตาปูน)",
                                            date: "11 มี.ค. 2568",
                                            time: c["time"],
                                            instructor: "Hub",
                                            imagePath: c["imagePath"],
                                            instructorImage: "assets/images/instructor_hub.jpg",
                                            isFull: c["isFull"],
                                          ),
                                        ),
                                      );
                                    },
                              child: Text(c["isFull"] ? "เต็มแล้ว" : "จอง", style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
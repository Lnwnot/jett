import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/class_provider.dart';
import '../screens/class_screen.dart';

class MyClassScreen extends StatefulWidget {
  const MyClassScreen({super.key});

  @override
  _MyClassScreenState createState() => _MyClassScreenState();
}

class _MyClassScreenState extends State<MyClassScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Text("คลาสของฉัน", style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "จองแล้ว"),
            Tab(text: "เช็คอินแล้ว"),
            Tab(text: "ยกเลิกแล้ว"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildClassList(context, classProvider.bookedClasses, classProvider, "booked"),
          _buildClassList(context, classProvider.checkedInClasses, classProvider, "checkedIn"),
          _buildClassList(context, classProvider.canceledClasses, classProvider, "canceled"),
        ],
      ),
    );
  }

  Widget _buildClassList(BuildContext context, List<Map<String, dynamic>> classes, ClassProvider provider, String tab) {
    if (classes.isEmpty) {
      return const Center(
        child: Text("ไม่มีข้อมูลคลาส", style: TextStyle(fontSize: 16, color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        var classData = classes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Image.asset(classData["imagePath"], width: 60, height: 60, fit: BoxFit.cover),
            title: Text(classData["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${classData["category"]} • ${classData["date"]} • ${classData["time"]}"),
            trailing: _buildActions(context, classData, provider, tab),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassScreen(
                    title: classData["title"],
                    description: "${classData["title"]} is a fitness class focused on ${classData["category"]}.",
                    category: classData["category"],
                    spotsLeft: "0", // Example placeholder
                    totalSpots: "20",
                    location: classData["location"],
                    date: classData["date"],
                    time: classData["time"],
                    instructor: classData["instructor"],
                    imagePath: classData["imagePath"],
                    instructorImage: classData["instructorImage"],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, Map<String, dynamic> classData, ClassProvider provider, String tab) {
    if (tab == "booked") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            onPressed: provider.isCheckedIn(classData["title"])
                ? null // Disable if already checked in
                : () {
                    provider.checkInClass(classData);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${classData["title"]} เช็คอินสำเร็จ!")));
                  },
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () {
              provider.cancelClass(classData);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${classData["title"]} ถูกยกเลิก!")));
            },
          ),
        ],
      );
    } else if (tab == "checkedIn") {
      return const Text("เช็คอินแล้ว", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
    } else if (tab == "canceled") {
      return const Text("ยกเลิกแล้ว", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
    }
    return const Icon(Icons.arrow_forward_ios, color: Colors.grey);
  }
}
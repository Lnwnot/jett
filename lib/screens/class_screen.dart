import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/class_provider.dart';

class ClassScreen extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String spotsLeft;
  final String totalSpots;
  final String location;
  final String date;
  final String time;
  final String instructor;
  final String imagePath;
  final String instructorImage;
  final bool isFull;

  const ClassScreen({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.spotsLeft,
    required this.totalSpots,
    required this.location,
    required this.date,
    required this.time,
    required this.instructor,
    required this.imagePath,
    required this.instructorImage,
    this.isFull = false,
  });

  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassProvider>(context);
    bool isAlreadyBooked = classProvider.bookedClasses.any((c) => c["title"] == title);
    bool isCheckedIn = classProvider.isCheckedIn(title); // 🔹 Check if already checked in

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(imagePath, height: 200, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 40,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(description, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: const Text("อ่านเพิ่มเติม", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 15),
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
                      child: Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  const SizedBox(height: 15),
                  Row(children: [const Icon(Icons.people, color: Colors.red), const SizedBox(width: 10), Text("ว่าง $spotsLeft จาก $totalSpots ที่")]),
                  const SizedBox(height: 10),
                  Row(children: [const Icon(Icons.location_on, color: Colors.red), const SizedBox(width: 10), Text(location)]),
                  const SizedBox(height: 10),
                  Row(children: [const Icon(Icons.calendar_today, color: Colors.red), const SizedBox(width: 10), Text("$date เวลา $time")]),
                  const SizedBox(height: 15),
                  const Text("Instructor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      CircleAvatar(radius: 25, backgroundImage: AssetImage(instructorImage)),
                      const SizedBox(width: 10),
                      Text(instructor, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Booking & Check-In Buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔴 Check-In Button (Disabled if already checked in)
            if (isAlreadyBooked)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCheckedIn ? Colors.grey : Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: isCheckedIn
    ? null // ✅ Disable button if already checked in
    : () {
        classProvider.checkInClass({
          "title": title,
          "category": category,
          "date": date,
          "time": time,
          "location": location,
          "instructor": instructor,
          "imagePath": imagePath,
          "instructorImage": instructorImage,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("คุณได้เช็คอิน $title แล้ว!")));
      },
                child: Text(
                  isCheckedIn ? "เช็คอินแล้ว" : "เช็คอิน",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

            const SizedBox(height: 10),

            // 🔘 Booking / Cancel Booking Button
            if (!isCheckedIn)
              isAlreadyBooked
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        classProvider.cancelClass({
                          "title": title,
                          "category": category,
                          "date": date,
                          "time": time,
                          "location": location,
                          "instructor": instructor,
                          "imagePath": imagePath,
                          "instructorImage": instructorImage,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title ยกเลิกแล้ว!")));
                      },
                      child: const Text("ยกเลิกการจอง", style: TextStyle(color: Colors.white, fontSize: 16)),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        classProvider.addClass({
                          "title": title,
                          "category": category,
                          "date": date,
                          "time": time,
                          "location": location,
                          "instructor": instructor,
                          "imagePath": imagePath,
                          "instructorImage": instructorImage,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title จองแล้ว!")));
                        Navigator.pop(context);
                      },
                      child: const Text("จอง", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
          ],
        ),
      ),
    );
  }
}
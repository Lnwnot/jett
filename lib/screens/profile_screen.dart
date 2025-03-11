import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/profile.png"), // Replace with user profile image
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Akaratorn",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text("Red รายเดือน", style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                        const Text(
                          "23008act@gmail.com",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Account Settings Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Account Section Title
                Container(
                  color: Colors.white, // Ensure visibility
                  child: const Text(
                    "บัญชีของฉัน",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Explicitly set black
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildListTile(Icons.language, "ภาษาในแอป", trailing: const Text("TH | EN")),
                _buildListTile(Icons.settings, "ตั้งค่าบัญชี"),
                const SizedBox(height: 20),

                // Help Section Title
                Container(
                  color: Colors.white, // Ensure visibility
                  child: const Text(
                    "ช่วยเหลือ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Explicitly set black
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildListTile(Icons.notifications, "แจ้งเตือน"),
                _buildListTile(Icons.question_answer, "คำถามที่พบบ่อย"),
                _buildListTile(Icons.privacy_tip, "นโยบายความเป็นส่วนตัว"),
                const SizedBox(height: 20),

                // Logout Button
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "ออกจากระบบ",
                      style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // App Version
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "application version 1.1.1(166)",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, {Widget? trailing}) {
    return ListTile(
      leading: const Icon(Icons.circle, color: Colors.black), // Ensure icon is also black
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black), // Ensure text is black
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {
        // Implement Navigation or Action
      },
    );
  }
}
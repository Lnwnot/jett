import 'package:flutter/material.dart';
import '../widgets/login_button.dart';
import 'email_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/gym_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(height: 10),
                const Text(
                  'พบกับคลาสออกกำลังกายสุดมันส์ที่',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Text(
                  'Jetts Fitness',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                LoginButton(icon: Icons.apple, text: "ดำเนินการต่อด้วย Apple", bgColor: Colors.black),
                const SizedBox(height: 10),
                LoginButton(icon: Icons.g_mobiledata, text: "ดำเนินการต่อด้วย Google", bgColor: Colors.black),
                const SizedBox(height: 10),
                LoginButton(
                  icon: Icons.email,
                  text: "ดำเนินการต่อด้วยอีเมล",
                  bgColor: Colors.red,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailLoginScreen()));
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text('ดูคลับและคลาสของเรา →', style: TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
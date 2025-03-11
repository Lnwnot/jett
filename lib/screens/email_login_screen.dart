import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_navbar.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isButtonActive = false;
  bool isPasswordVisible = false;
  bool rememberPassword = false; // 🔹 "Remember Me" toggle

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  /// 🔹 Load saved email & password from SharedPreferences
  void _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('saved_email') ?? '';
      passwordController.text = prefs.getString('saved_password') ?? '';
      rememberPassword = prefs.getBool('remember_password') ?? false;
    });
    _updateButtonState(); // Update button state based on loaded data
  }

  /// 🔹 Save credentials when "Remember Me" is enabled
  void _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberPassword) {
      await prefs.setString('saved_email', emailController.text.trim());
      await prefs.setString('saved_password', passwordController.text.trim());
      await prefs.setBool('remember_password', true);
    } else {
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_password', false);
    }
  }

  /// 🔹 Update button state dynamically
  void _updateButtonState() {
    setState(() {
      isButtonActive = emailController.text.isNotEmpty && passwordController.text.length >= 6;
    });
  }

  /// 🔹 Sign in with Firebase & save credentials if "Remember Me" is checked
  void signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      _saveCredentials(); // Save credentials if "Remember Me" is checked
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } catch (e) {
      _showErrorDialog("เข้าสู่ระบบไม่สำเร็จ", e.toString());
    }
  }

  /// 🔹 Show error dialogs for login issues
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("ตกลง")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "ดำเนินการต่อด้วยอีเมล",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildTextField("ชื่อผู้ใช้งาน (อีเมล)", controller: emailController),
            const SizedBox(height: 15),
            _buildTextField("รหัสผ่าน", isPassword: true, controller: passwordController),
            const SizedBox(height: 10),

            /// 🔹 Remember Me Checkbox
            Row(
              children: [
                Checkbox(
                  value: rememberPassword,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      rememberPassword = value!;
                    });
                  },
                ),
                const Text("จำรหัสผ่าน", style: TextStyle(color: Colors.white)),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, // 🔐 Add forgot password function here
                child: const Text('ลืมรหัสผ่าน?', style: TextStyle(color: Colors.white70)),
              ),
            ),
            const Spacer(),

            /// 🔴 Login Button
            GestureDetector(
              onTap: isButtonActive ? signIn : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isButtonActive ? Colors.red : Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('ดำเนินการต่อ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// 🔵 Sign Up Button
            TextButton(
              onPressed: () {}, // 🚀 Add signup function here
              child: const Text("สร้างบัญชีใหม่", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),

            const SizedBox(height: 20),

            /// 🔍 Privacy Notice
            const Text(
              'การกดปุ่มดำเนินการต่อถือว่าคุณได้ยอมรับ\nและ นโยบายความเป็นส่วนตัว ของ Jetts Fitness แล้ว',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// **Reusable TextField with dynamic options**
  Widget _buildTextField(String label, {bool isPassword = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !isPasswordVisible : false, // Toggle password visibility
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}
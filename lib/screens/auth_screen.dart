import 'package:flutter/material.dart';
import 'package:test/screens/view_screen.dart';
import 'package:test/services/supabase_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  TextEditingController emailCTRL = TextEditingController();
  TextEditingController passwordCTRL = TextEditingController();

  void signUp() async {
    try {
      final user = await AuthUser(
        email: emailCTRL.text,
        password: passwordCTRL.text,
      );
      // if (user == null)
      print("auth user $user");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewScreen()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailCTRL,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextField(
              controller: passwordCTRL,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            ElevatedButton(onPressed: () => signUp(), child: Text("SIGN UP")),
          ],
        ),
      ),
    );
  }
}

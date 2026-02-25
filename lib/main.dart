import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/screens/auth_screen.dart';
import 'package:test/screens/insert_update_user_screen.dart';
import 'package:test/screens/view_screen.dart';
import 'package:test/services/supabase_service.dart';
import 'package:test/widgets/custom_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final res = await initialization();
  print(res);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MutationScreen(purpose: "insert"),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          appBar: CustomAppBar(title: "SUPABASE"),
          body: AuthScreen(),
        ),
      ),
    );
  }
}

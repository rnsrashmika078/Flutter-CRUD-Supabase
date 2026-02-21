import 'package:flutter/material.dart';
import 'package:test/services/supabase_service.dart';
import 'package:test/widgets/custom_app_bar.dart';

class MutationScreen extends StatefulWidget {
  final int? id;
  final String? name;
  final String? purpose;
  final int? age;
  final String? job;
  const MutationScreen({
    super.key,
    this.id,
    this.name,
    this.age,
    this.job,
    required this.purpose,
  });

  @override
  State<MutationScreen> createState() => _MutationScreen();
}

class _MutationScreen extends State<MutationScreen> {
  List<Map<String, dynamic>> users = [];
  TextEditingController nameCTRL = TextEditingController();
  TextEditingController ageCTRL = TextEditingController();
  TextEditingController jobCTRL = TextEditingController();

  @override
  void initState() {
    nameCTRL = TextEditingController(text: widget.name);
    ageCTRL = TextEditingController(
      text: widget.age != null ? widget.age.toString() : "",
    );
    jobCTRL = TextEditingController(text: widget.job);
    super.initState();
  }

  void onSubmit() async {
    if (widget.purpose == "insert") {
      Map<String, dynamic> newUser = {
        'name': nameCTRL.text,
        'age': int.tryParse(ageCTRL.text) ?? 0,
        'job': jobCTRL.text,
      };
      final res = await insertUser(newUser);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else if (widget.purpose == "update") {
      Map<String, dynamic> newUser = {
        'name': nameCTRL.text,
        'age': int.tryParse(ageCTRL.text) ?? 0,
        'job': jobCTRL.text,
      };
      final res = await updateUser(widget.id!, newUser);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "SUPABASE"),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: nameCTRL,
                    decoration: InputDecoration(
                      labelText: "Enter your name",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: ageCTRL,
                    decoration: InputDecoration(
                      labelText: "Enter your age",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: jobCTRL,
                    decoration: InputDecoration(
                      labelText: "Enter your job",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  ElevatedButton(
                    onPressed: () => onSubmit(),
                    child: Text(widget.id != null ? "Update" : "Insert"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

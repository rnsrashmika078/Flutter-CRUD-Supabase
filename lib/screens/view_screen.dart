import 'package:flutter/material.dart';
import 'package:test/screens/insert_update_user_screen.dart';
import 'package:test/services/supabase_service.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreen();
}

class _ViewScreen extends State<ViewScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final allUsers = await getUsers();
    setState(() {
      users = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MutationScreen(purpose: "insert"),
                        ),
                      ).then((_) {
                        fetchUsers();
                      }),
                  child: Text("Add User"),
                ),
              ],
            ),
          ),
          users.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              users[index]['name'][0],
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name: ${users[index]['name']}",
                                            ),
                                            Text(
                                              "Age: ${users[index]['age'].toString()}",
                                            ),
                                            Text("Job: ${users[index]['job']}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MutationScreen(
                                                        purpose: "update",
                                                        id: users[index]['id'],
                                                        name:
                                                            users[index]['name'],
                                                        age:
                                                            users[index]['age'],
                                                        job:
                                                            users[index]['job'],
                                                      ),
                                                ),
                                              ).then((_) {
                                                fetchUsers();
                                              }),
                                          icon: Icon(Icons.edit),
                                        ),
                                        SizedBox(width: 20),
                                        IconButton(
                                          onPressed: () async {
                                            final res = await deleteUser(
                                              users[index]['id'],
                                            );
                                            fetchUsers();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text(res)),
                                            );
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Column(children: [Text("No Users found!")]),
        ],
      ),
    );
  }
}

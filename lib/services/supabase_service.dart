import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final table = dotenv.env['TABLE']!;
Future<String> initialization() async {
  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );

    return "Supabase connection successful!";
  } catch (e) {
    return e.toString();
  }
}

Future<List<Map<String, dynamic>>> getUsers() async {
  final users = await Supabase.instance.client.from(table).select();
  print("Users $users");
  return users;
}

Future<String> insertUser(Map<String, dynamic> newUser) async {
  final insertUser = await Supabase.instance.client
      .from(table)
      .upsert(newUser)
      .select()
      .maybeSingle();

  if (insertUser != null) {
    return "User inserted successfully!";
  }
  return "Error while insert user!";
}

Future<String> updateUser(int id, Map<String, dynamic> updateUserData) async {
  final updateUser = await Supabase.instance.client
      .from(table)
      .update(updateUserData)
      .eq("id", id)
      .select()
      .maybeSingle();

  if (updateUser != null) {
    return "User updated successfully!";
  }
  return "Error while insert user!";
}

Future<String> deleteUser(int id) async {
  final deletedUser = await Supabase.instance.client
      .from(table)
      .delete()
      .eq('id', id)
      .select()
      .maybeSingle();
  if (deletedUser != null) {
    return "User deleted successfully!";
  }
  return "Error while delete user!";
}

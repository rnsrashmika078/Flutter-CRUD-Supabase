- **`Packages`**  
   supabase_flutter: ^2.12.0
  flutter_dotenv: ^6.0.0 `not super important`
- **`Packages`**  
   SUPABASE_URL=your_supabase_url
  SUPABASE_ANON_KEY=your_supabase_anon_key
  TABLE=your_table_name`

## Initialize Supabase

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final res = await initialization();
  print(res);
  runApp(MyApp());
}
```

- **`Supabase service`**  
   Crud function located in lib/services/supabase_service.dart

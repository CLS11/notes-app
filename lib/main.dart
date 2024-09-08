import 'package:flutter/material.dart';
import 'package:offline_database/models/note_database.dart';
import 'package:offline_database/pages/note_page.dart';
import 'package:offline_database/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  //Initialise note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialise();
  runApp(
    MultiProvider(
      providers: [
        // Note provider
        ChangeNotifierProvider(
          create: (context) => NoteDatabase(),
          child: const NotesApp(),
        ),
        // Theme provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          child: const NotesApp(),
        ),
      ],
    ),
  );
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

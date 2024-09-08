import 'package:flutter/material.dart';
import 'package:offline_database/models/note_database.dart';
import 'package:offline_database/pages/note_page.dart';
import 'package:provider/provider.dart';

void main() async {
  //Initialise note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialise();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const NotesApp(),
    ),
  );
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}

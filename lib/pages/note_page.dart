import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offline_database/components/drawer.dart';
import 'package:offline_database/components/note_tile.dart';
import 'package:offline_database/models/note.dart';
import 'package:offline_database/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller to access what user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //on app startup, fetch existing notes
    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: TextField(
          controller: textController,
        ),
        actions: [
          //create button
          MaterialButton(
            onPressed: () {
              // add to database
              context.read<NoteDatabase>().addNote(textController.text);

              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // read the note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  void updateNote(Note note) {
    // prefill text field
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Update Note'),
        content: TextField(controller: textController),
        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              //updating notes in database
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              //clear the controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();
    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child:  Icon(Icons.add,color: Theme.of(context).colorScheme.inversePrimary),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'NOTES',
              style: GoogleFonts.dmSerifText(
                fontSize: 50,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          //Notes list
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                // get individual note
                final note = currentNotes[index];

                //list tile UI
                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id), 
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

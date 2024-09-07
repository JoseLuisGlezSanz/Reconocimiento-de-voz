import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedNotesScreen extends StatefulWidget {
  final List<String> notes;

  const SavedNotesScreen({super.key, required this.notes});

  @override
  _SavedNotesScreenState createState() => _SavedNotesScreenState();
}

class _SavedNotesScreenState extends State<SavedNotesScreen> {
  late List<bool> _selectedNotes;

  @override
  void initState() {
    super.initState();
    _selectedNotes = List.generate(widget.notes.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Notas Guardadas",
          style: TextStyle(color: Colors.white), // Cambio de color a blanco
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copySelectedNotes,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteSelectedNotes,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              widget.notes[index],
              style: TextStyle(color: Colors.white), // Cambio de color a blanco
            ),
            onTap: () {
              setState(() {
                _selectedNotes[index] = !_selectedNotes[index];
              });
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedNotes[index])
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteSingleNote(index);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    _copySingleNote(widget.notes[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _copySingleNote(String note) {
    Clipboard.setData(ClipboardData(text: note));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Nota copiada'),
      duration: Duration(seconds: 1),
    ));
  }

  void _deleteSingleNote(int index) {
    setState(() {
      widget.notes.removeAt(index);
      _selectedNotes.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Nota eliminada'),
      duration: Duration(seconds: 1),
    ));
  }

  void _copySelectedNotes() {
    final selectedNotes = <String>[];
    for (int i = 0; i < _selectedNotes.length; i++) {
      if (_selectedNotes[i]) {
        selectedNotes.add(widget.notes[i]);
      }
    }
    final String allNotes = selectedNotes.join('\n');
    Clipboard.setData(ClipboardData(text: allNotes));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Notas copiadas'),
      duration: Duration(seconds: 1),
    ));
  }

  void _deleteSelectedNotes() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar notas seleccionadas'),
          content: const Text('¿Está seguro de que desea eliminar las notas seleccionadas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                for (int i = widget.notes.length - 1; i >= 0; i--) {
                  if (_selectedNotes[i]) {
                    widget.notes.removeAt(i);
                    _selectedNotes.removeAt(i);
                  }
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Notas eliminadas'),
                  duration: Duration(seconds: 1),
                ));
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
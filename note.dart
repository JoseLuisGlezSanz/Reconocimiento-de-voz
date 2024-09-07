import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'saved_notes.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedText = "";
  final ValueNotifier<bool> _isListeningNotifier = ValueNotifier<bool>(false);
  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _initSpeechState();
  }

  void _initSpeechState() async {
    bool available = await _speech.initialize();
    if (!mounted) return;
    _isListeningNotifier.value = available;
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedWords;
        });
      },
    );
    _isListeningNotifier.value = true;
  }

  void _stopListening() {
    _speech.stop();
    _isListeningNotifier.value = false;
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: _recognizedText));
    _showSnackBar("Texto copiado");
  }

  void _clearText() {
    setState(() {
      _recognizedText = "";
    });
  }

  void _saveNote() {
    if (_recognizedText.isNotEmpty) {
      setState(() {
        _notes.add(_recognizedText);
        _recognizedText = "";
      });
      _showSnackBar("Nota guardada");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  void _navigateToNotes() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SavedNotesScreen(notes: _notes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(208, 6, 15, 27), 
        //title: const Text("Nota"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _navigateToNotes,
            color: Colors.white, // Cambia el color del ícono aquí
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _isListeningNotifier,
              builder: (context, isListening, child) {
                return IconButton(
                  onPressed: isListening ? _stopListening : _startListening,
                  icon: Icon(isListening ? Icons.mic : Icons.mic_none),
                  iconSize: 100,
                  color: isListening ? Colors.red : Colors.grey,
                );
              },
            ),
            SizedBox(height: 40,),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView( // Añado un SingleChildScrollView para manejar textos largos
                child: Text(
                  _recognizedText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white, // Cambia el color del texto aquí
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _recognizedText.isNotEmpty ? _copyText : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Copiar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: _clearText,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Limpiar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: _saveNote,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

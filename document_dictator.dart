import 'package:flutter/material.dart';
import 'game.dart';
import 'note.dart';

class DocumentDictator extends StatelessWidget {
  const DocumentDictator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: const Text('Dictado interactivo'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            choice(), //
            choose(),
            const SizedBox(height: 40.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                elevation: 4,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Note(),
                    ),
                );
              },
              child: const Text('Nota',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 30.0), 
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                elevation: 4,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpeechGameApp()
                    ),
                ); 
              },
              child: const Text('Juego',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget choice() {
  return Container(
    margin: const EdgeInsets.all(20), 
    child: const Center(
      child: Text(
        "¿Qué deseas elegir?",
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 37, color: Colors.white),
      ),
    ),
  );
}

Widget choose() {
  return const Center(
    child: Text(
      "Selecciona una opción",
      textAlign: TextAlign.center, 
      style: TextStyle(fontSize: 25, color: Colors.white),
    ),
  );
}
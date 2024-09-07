import 'package:flutter/material.dart';

class Reminder extends StatelessWidget{
  const Reminder ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recordatorio'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Acción al presionar el botón
          }, // Personaliza el texto del botón
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0), // Ajusta el tamaño circular
            ),
            padding: const EdgeInsets.all(45.0), // Ajusta el relleno del botón
          ),
          child: const Text('Grabar',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );

    
  }
}
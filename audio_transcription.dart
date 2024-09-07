import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'main_menu.dart';

class audio_transcription extends StatefulWidget {
  const audio_transcription({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AudioTranscriptionState createState() => _AudioTranscriptionState();
}

class _AudioTranscriptionState extends State<audio_transcription> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _transcription = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _transcription = val.recognizedWords;
        }),
      );
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Audio Transcription'),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 60,),
              hablaEnVozAltaTxT(),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: _isListening ? _stopListening : _startListening,
                child: SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/thumbnails/019/940/416/small/audio-recording-icon-on-transparent-background-free-png.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              transcripcionTxT(),
              cuadroTranscripcion(),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(title: '',),
                    ),
                  );
                },
                child: Text(
                  'Salir',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container hablaEnVozAltaTxT() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Habla en voz alta",
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
  
  Container transcripcionTxT() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Transcripción",
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  Container cuadroTranscripcion() {
    return Container(
      width: 360.0,
      height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.all(10.0), // Espaciado alrededor de cada container
      child: TextFormField(
        style: const TextStyle(fontSize: 20.0),
        maxLines: null, // Permite múltiples líneas
        decoration: const InputDecoration(border: InputBorder.none),
        controller: TextEditingController(text: _transcription),
      ),
    );
  }
}
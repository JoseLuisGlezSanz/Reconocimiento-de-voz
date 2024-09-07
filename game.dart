import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:math';

class SpeechGameApp extends StatelessWidget {
  const SpeechGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de voz',
      debugShowCheckedModeBanner: false, // Ocultar el banner de debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpeechGameScreen(),
    );
  }
}

class SpeechGameScreen extends StatefulWidget {
  const SpeechGameScreen({super.key});

  @override
  _SpeechGameScreenState createState() => _SpeechGameScreenState();
}

class _SpeechGameScreenState extends State<SpeechGameScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Presiona el botón';
  int _score = 0;
  late String _targetWord;

  final List<String> _words = [
    'accept', 'add', 'admire', 'admit', 'advise', 'allow', 'answer', 'apologize', 'appear', 'apply',
    'argue', 'arrive', 'ask', 'bake', 'bathe', 'become', 'beg', 'begin', 'believe', 'belong', 'borrow',
    'break', 'bring', 'build', 'burn', 'buy', 'call', 'care', 'carry', 'catch', 'change', 'choose',
    'clean', 'climb', 'close', 'come', 'complain', 'complete', 'cook', 'copy', 'cost', 'count', 'cover',
    'create', 'cross', 'cry', 'cut', 'dance', 'decide', 'deliver', 'describe', 'design', 'destroy',
    'develop', 'die', 'disagree', 'discover', 'discuss', 'dislike', 'do', 'draw', 'dream', 'drink',
    'drive', 'eat', 'enable', 'encourage', 'enjoy', 'examine', 'exist', 'expect', 'explain', 'fall',
    'fasten', 'feed', 'feel', 'fight', 'find', 'finish', 'fit', 'fix', 'fly', 'follow', 'forget', 'forgive',
    'freeze', 'get', 'give', 'go', 'grow', 'guess', 'handle', 'happen', 'hate', 'have', 'hear', 'hide',
    'hit', 'hold', 'hope', 'hurt', 'identify', 'imagine', 'improve', 'include', 'increase', 'influence',
    'inform', 'insist', 'introduce', 'invite', 'join', 'jump', 'keep', 'kick', 'kiss', 'know', 'laugh',
    'learn', 'leave', 'lend', 'let', 'like', 'listen', 'live', 'look', 'lose', 'love', 'make', 'marry',
    'mean', 'meet', 'move', 'need', 'notice', 'offer', 'open', 'order', 'own', 'paint', 'participate',
    'pay', 'play', 'prepare', 'pretend', 'produce', 'protect', 'prove', 'pull', 'push', 'put', 'read',
    'receive', 'recognize', 'record', 'remember', 'repeat', 'replace', 'reply', 'report', 'rest',
    'return', 'ride', 'ring', 'rise', 'run', 'save', 'say', 'see', 'sell', 'send', 'serve', 'set',
    'share', 'show', 'shut', 'sing', 'sit', 'sleep', 'smell', 'speak', 'stand', 'start', 'stay',
    'steal', 'study', 'succeed', 'suggest', 'support', 'swim', 'take', 'talk', 'teach', 'tell',
    'thank', 'think', 'throw', 'touch', 'travel', 'try', 'turn', 'type', 'understand', 'use',
    'wait', 'wake', 'walk', 'want', 'watch', 'win', 'wish', 'work', 'worry', 'write'
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _setRandomWord();
  }

  void _setRandomWord() {
    final random = Random();
    _targetWord = _words[random.nextInt(_words.length)];
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (_text.toLowerCase().contains(_targetWord)) {
              _score++;
              _text = 'Dijiste la palabra correctamente';
              _setRandomWord();
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Juego de reconocimiento de voz'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Di la palabra: "$_targetWord"',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              _text,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              'Puntuación: $_score',
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}

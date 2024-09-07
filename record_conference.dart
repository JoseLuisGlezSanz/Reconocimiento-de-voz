import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class RecordConference extends StatefulWidget {
  const RecordConference({super.key});

  @override
  State<RecordConference> createState() => _RecordConferenceState();
}

class _RecordConferenceState extends State<RecordConference> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    await recorder.openRecorder();
    isRecorderReady = true;

    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future<String> getDownloadsDirectoryPath() async {
    Directory? directory;

    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      directory = await getDownloadsDirectory();
    } else {
      throw UnsupportedError("Platform not supported");
    }

    if (directory == null) {
      throw Exception("Unable to get downloads directory");
    }

    return directory.path;
  }

  Future record() async {
    if (!isRecorderReady) return;

    // Get the directory to save the file
    final directoryPath = await getDownloadsDirectoryPath();
    audioPath = path.join(directoryPath, 'audio.mp4');

    print('Recording to: $audioPath'); // Log the file path

    await recorder.startRecorder(toFile: audioPath, codec: Codec.aacMP4);
    setState(() {
      isRecording = true;
    });
  }

  Future stop() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    if (path == null) {
      print('Recording stopped, but no file path returned');
      return;
    }

    final audioFile = File(path);

    print('Audio recorded to: $audioFile');
    setState(() {
      isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(208, 6, 15, 27),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration = snapshot.hasData
                    ? snapshot.data!.duration
                    : Duration.zero;

                return Text(
                  '${duration.inSeconds} s',
                  style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: Icon(
                isRecording ? Icons.stop : Icons.mic,
                size: 80,
              ),
              onPressed: () async {
                if (isRecording) {
                  await stop();
                } else {
                  await record();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

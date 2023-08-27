import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'colors.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();

  var text = "Hold the Button to Speak";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // action button on bottom
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListening,
          duration: const Duration(milliseconds: 2000),
          glowColor: bgColor,
          repeat: true,
          repeatPauseDuration: const Duration(milliseconds: 100),
          showTwoGlows: true,

          // GestureDetector is a widget that detects gestures
          child: GestureDetector(
            onTapDown: (details) async {
              if (!isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(
                      onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                        });
                      },
                    );
                  });
                }
              }
            },

            onTapUp: (details) {
              setState(() {
                isListening = false;
              });
              speechToText.stop();
            },

            // CircleAvatar is a circular widget with background color and radius
            child: CircleAvatar(
              backgroundColor: bgColor,
              radius: 35,
              child: Icon(isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.white),
            ),
          )),

      // navigation bar
      appBar: AppBar(
        leading: const Icon(Icons.sort_rounded, color: Colors.white),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0.0,
        title: const Text('Speech To Text',
            style: TextStyle(
              color: textColor,
            )),
      ),

      // body of the screen
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          // color: Colors.red,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin:
              const EdgeInsets.only(bottom: 150, left: 16, right: 16, top: 16),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 24,
                color: isListening ? Colors.black87 : Colors.black54,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

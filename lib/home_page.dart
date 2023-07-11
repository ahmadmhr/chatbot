

import 'package:chatbot/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'feature_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async{
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print(lastWords);
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allen'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //VirtualAssistant image
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 105,
                    width: 105,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 110,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage('assets/images/virtualAssistant.png')),
                    ),
                  ),
                )
              ],
            ),
            //message
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30).copyWith(
                top: 10
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(18)).copyWith(
                  topLeft: Radius.zero,
                )
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    'Good Morning! What task I can do for you',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 17,
                    color: Pallete.mainFontColor,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 5,left: 10),
              child: const Text(
                  'Here are some features',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
              ),
            ),
            //feature
              Column(
                children: const [
                  FeatureBox(colour: Pallete.firstSuggestionBoxColor, header: 'ChatGPT',description: 'A smarter way to stay organized and informed with ChatGPT',),
                  FeatureBox(colour: Pallete.secondSuggestionBoxColor, header: 'Dall-E',description: 'Get inspired and stay creative with you personal assistant powered by Dall-E',),
                  FeatureBox(colour: Pallete.thirdSuggestionBoxColor, header: 'Smart Voice Assistant',description: 'Get the best of both worlds with voice assistant powered by ChatGPT and Dall-E',)
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(await speechToText.hasPermission && speechToText.isNotListening){
            await startListening();
          }
          else if(speechToText.isListening){
            await stopListening();
          }
          else{
            initSpeechToText();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }
}

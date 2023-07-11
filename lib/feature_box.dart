import 'package:chatbot/pallete.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color colour;
  final String header;
  final String description;
  const FeatureBox({Key? key, required this.colour, required this.header, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 18,
                  color: Pallete.blackColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 15,
                  color: Pallete.blackColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

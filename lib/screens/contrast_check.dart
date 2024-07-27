import 'package:flutter/material.dart';

import 'home.dart';

class ContrastCheck extends StatefulWidget {
  static const route = "/contrast-check";
  const ContrastCheck({super.key});

  @override
  State<ContrastCheck> createState() => _ContrastCheckState();
}

class _ContrastCheckState extends State<ContrastCheck> {
  Color foregroundColor = Colors.black;
  Color backgroundColor = Colors.white;
  double contrastRatio = 0.0;
  double backgroundLuminanceValue = 0.8;

  void updateBackgroundColor(double value) {
    backgroundLuminanceValue = value;
    setState(() {
      backgroundColor = Color(0xFF000000 + ((1 - value) * 255).toInt() * 0x010101);
    });
    calculateContrastRatio();
  }

  void calculateContrastRatio() {
    var luminance1 = foregroundColor.computeLuminance();
    var luminance2 = backgroundColor.computeLuminance();
    var ratio = (luminance1 + 0.05) / (luminance2 + 0.05);
    setState(() {
      contrastRatio = ratio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contrast Checker',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Use the slider to adjust the background color, till the text is readable.'),
            Container(
              width: 200,
              height: 200,
              color: backgroundColor,
              child: Center(
                child: Text(
                  'Contrast Check',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: foregroundColor, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Contrast Ratio: ${contrastRatio.toStringAsFixed(2)}'),
            Slider(
              min: 0.8,
              max: 1,
              value: backgroundLuminanceValue,
              onChanged: updateBackgroundColor,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName(Home.route));
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import 'home.dart';

class ColorScope extends StatefulWidget {
  static const route = "/color-scope";
  const ColorScope({super.key});

  @override
  State<ColorScope> createState() => _ColorScopeState();
}

class _ColorScopeState extends State<ColorScope> {
  final List<Color> colors = [];
  String userInput = '0';
  int colorCount = 100;
  String colorAlignment = 'vertical';

  @override
  void initState() {
    super.initState();
    var random = Random();
    int percentageChange = (colorCount * 0.1).toInt();

    colorCount += random.nextInt((percentageChange * 2)) - percentageChange;
    colors.addAll(colorsGenerator(colorCount));
  }

  // ColorsGenerator - Generate a list of colors in order of gradient based on the number of colors
  colorsGenerator(int numberOfColors) {
    List<Color> colors = [];
    for (int i = 0; i < numberOfColors; i++) {
      colors.add(HSVColor.fromAHSV(1.0, i * 360 / numberOfColors, 1.0, 1.0).toColor());
    }
    return colors;
  }

  // getPercentage - Calculate the percentage of the color based on the user input
  getPercentage() {
    if (userInput.isEmpty) {
      return 'Please enter a value';
    }
    if (int.parse(userInput) < 0 || int.parse(userInput) > colors.length) {
      return 'Invalid input';
    }
    var percentage = int.parse(userInput) / colors.length * 100;
    return percentage.toStringAsFixed(2).toString();
  }

  // getRating - Calculate the rating based on percentage
  getRating() {
    var percentage = getPercentage();
    if (percentage == 'Please enter a value' || percentage == 'Invalid input') {
      return '';
    }
    percentage = double.parse(percentage);
    if (percentage >= 80) {
      return 'Excellent';
    }
    if (percentage >= 60) {
      return 'Good';
    }
    if (percentage >= 50) {
      return 'Fair';
    }
    return 'Poor';
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Color Scope",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: colorAlignment == 'horizontal' ? Axis.horizontal : Axis.vertical,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    var colorWidth = colorAlignment == 'horizontal' ? width / colors.length : width;
                    var colorHeight = colorAlignment == 'horizontal' ? height - 130 : (height - 130) / colors.length;
                    return Container(
                      width: colorWidth,
                      height: colorHeight,
                      color: colors[index],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Rating: ${getRating()}'),
                    Text('Percentage: ${getPercentage()}%'),
                    // Input text box and update the value automatically
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Colors?'),
                        onChanged: (value) {
                          setState(() {
                            userInput = value;
                          });
                        },
                      ),
                    ),
                    // +/ - buttons to increase or decrease total colors
                    SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.rotate_left),
                            onPressed: () {
                              setState(() {
                                colorAlignment = colorAlignment == 'horizontal' ? 'vertical' : 'horizontal';
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                colorCount += 5;
                                colors.clear();
                                colors.addAll(colorsGenerator(colorCount));
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (colorCount > 5) {
                                  colorCount -= 5;
                                }
                                colors.clear();
                                colors.addAll(colorsGenerator(colorCount));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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

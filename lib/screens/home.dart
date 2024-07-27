import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const route = "/home";
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  var tools = {
    "Color Scope": {
      "description": "Measures your screen's ability to display accurate colors.",
      "route": "/color-scope",
    },
    "Resolution Count": {
      "description": "Determines your screen's resolution and pixel count.",
      "route": "/resolution-count",
    },
    "Refresh Meter": {
      "description": "Checks your screen's refresh rate for smooth motion.",
      "route": "/refresh-meter",
    },
    "Contrast Check": {
      "description": "Measures the difference between the darkest and lightest colors on your screen.",
      "route": "/contrast-check",
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Display Detective"),
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var tool in tools.entries)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                    ),
                    child: ListTile(
                      title: Text(tool.key, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      subtitle: Text(tool.value['description']!, textAlign: TextAlign.center),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        Navigator.pushNamed(context, tool.value['route']!);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}

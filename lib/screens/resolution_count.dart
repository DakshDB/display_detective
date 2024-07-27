import 'dart:html' as html;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class ResolutionCount extends StatefulWidget {
  static const route = "/resolution-count";

  const ResolutionCount({super.key});

  @override
  State<ResolutionCount> createState() => _ResolutionCountState();
}

class _ResolutionCountState extends State<ResolutionCount> {
  bool isFullScreen = false;

  void toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
      if (kIsWeb) {
        if (isFullScreen) {
          html.document.documentElement?.requestFullscreen();
        } else {
          html.document.exitFullscreen();
        }
        return;
      }

      if (isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      html.document.onFullscreenChange.listen((_) {
        setState(() {
          isFullScreen = html.document.fullscreenElement != null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the logical screen size
    var logicalScreenSize = MediaQuery.of(context).size;
    var logicalWidth = logicalScreenSize.width;
    var logicalHeight = logicalScreenSize.height;

    // Get the device pixel ratio
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Calculate the physical screen size
    var physicalWidth = logicalWidth * pixelRatio;
    var physicalHeight = logicalHeight * pixelRatio;

    var orientation = MediaQuery.of(context).orientation;

    // Pixel count
    var pixelCount = physicalWidth * physicalHeight;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Screen Resolution and Pixel Count',
            ),
            Text('Physical Width: $physicalWidth'),
            Text('Physical Height: $physicalHeight'),

            Text('Pixel Ratio: $pixelRatio'),

            Text('Pixel Count: $pixelCount'),

            Text('Orientation: $orientation'),

            // Button to make full screen
            ElevatedButton(
              onPressed: toggleFullScreen,
              child: Text(isFullScreen ? 'Exit Full Screen' : 'Enter Full Screen'),
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

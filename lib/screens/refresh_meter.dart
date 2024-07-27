import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'home.dart';

class RefreshMeter extends StatefulWidget {
  static const route = "/refresh-meter";

  const RefreshMeter({super.key});
  @override
  State<RefreshMeter> createState() => _RefreshMeterState();
}

class _RefreshMeterState extends State<RefreshMeter> with TickerProviderStateMixin, WidgetsBindingObserver {
  late final Ticker _ticker;
  Timer? _timer;

  double _refreshRate = 0;
  final List<double> _frameTimes = [];
  static const int _maxFrames = 20; // Number of frames to average

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (Timer t) => _updateRefreshRate());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    _frameTimes.add(elapsed.inMicroseconds * 1000.0); // Convert microseconds to nanoseconds
    if (_frameTimes.length > _maxFrames) {
      _frameTimes.removeAt(0);
    }
  }

  void _updateRefreshRate() {
    if (_frameTimes.length > 1) {
      final totalDelta = _frameTimes.last - _frameTimes.first;
      final averageDelta = totalDelta / (_frameTimes.length - 1);
      _refreshRate = 1e9 / averageDelta; // Convert nanoseconds to Hz
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Current Screen Refresh Rate: ${_refreshRate.toStringAsFixed(2)} Hz',
          style: TextStyle(fontSize: 24),
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

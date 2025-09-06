import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LockoutTimer extends StatefulWidget {
  final int endTime;

  const LockoutTimer({Key? key, required this.endTime}) : super(key: key);

  @override
  _LockoutTimerState createState() => _LockoutTimerState();
}

class _LockoutTimerState extends State<LockoutTimer> {
  late DateTime endDateTime;
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    endDateTime = DateTime.fromMillisecondsSinceEpoch(widget.endTime);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        _remainingTime = endDateTime.difference(now);
      });

      if (_remainingTime.isNegative) {
        _timer.cancel();
        Get.back(); // Navigate back to login screen after timer ends
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'You have made too many failed login attempts.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Text(
          'Please try again in:',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Text(
          DateFormat.ms().format(
            DateTime(0).add(_remainingTime),
          ),
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/index.dart';

class CountdownTimer extends StatefulWidget {
  CountdownController controller;
  CountdownTimer({
    super.key,
    required this.controller,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  //CountdownController _controller = new CountdownController()
  @override
  Widget build(BuildContext context) {
    return Countdown(
              countdownController: widget.controller,
              
            );
  }
}
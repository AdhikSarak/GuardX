import 'package:flutter/material.dart'; 
import 'package:guardx/widgets/lock_out.dart';

class LockoutScreen extends StatelessWidget {
  final int endTime;

  const LockoutScreen({Key? key, required this.endTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LockoutTimer(endTime: endTime),
      ),
    );
  }
}

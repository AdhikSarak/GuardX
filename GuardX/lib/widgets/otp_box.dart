import 'package:flutter/material.dart';

class CustomOtpBox extends StatelessWidget {
  final int index;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const CustomOtpBox({
    super.key,
    required this.index,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: TextFormField(
            focusNode: focusNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: onChanged,
            decoration: const InputDecoration(
              counter: SizedBox(),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

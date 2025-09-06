import 'package:flutter/material.dart';

class ProfileBtn extends StatelessWidget {
  final IconData prefixIcon;
  final String labelText;
  final String descriptionText;
  VoidCallback ontap;

   ProfileBtn({
    super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.descriptionText,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Row(
          children: [
            Icon(prefixIcon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelText,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    descriptionText,
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

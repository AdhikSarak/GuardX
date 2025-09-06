import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onPressed;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? passwordStrength;
  final String? errortext;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.decoration,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.suffixIconColor,
    this.keyboardType,
    this.obscureText,
    this.onPressed,
    this.passwordStrength,
    this.errortext,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            errorText: widget.errortext,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true, // Ensure that the fillColor is applied
            hintStyle: TextStyle(color: Colors.grey[600]), // Hint text color
            errorStyle: TextStyle(color: Colors.red), // Error text color
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.onPressed,
                    child: Icon(
                      widget.suffixIcon,
                      color: widget.suffixIconColor ?? Colors.grey,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),  
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Colors.blue), // Focused border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Colors.grey[300]!), // Enabled border color
            ),
          ),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: TextStyle(color: Colors.black), // Text color
        ),
        if (widget.passwordStrength != null) widget.passwordStrength!,
      ],
    );
  }
}

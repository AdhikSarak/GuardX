import 'package:guardx/consts/index.dart';

class PasswordCustomTextField extends StatefulWidget {
  final String heading;
  final String? Function(String?)? validator;
  Icon? icon;
  String textLabel;
  IconButton? suffixIcon1;
  IconButton? suffixIcon2;
  String? prefixText;
  bool isPass = false;
  bool readOnly = false;
  String? initialValue;
  TextInputType? textInputType;
  TextEditingController? textEditingController;
  PasswordCustomTextField({
    super.key,
    required this.heading,
    this.icon,
    required this.textLabel,
    this.validator,
    this.suffixIcon1,
    this.suffixIcon2,
    this.prefixText,
    required this.readOnly,
    this.initialValue,
    this.textEditingController,
  });

  @override
  State<PasswordCustomTextField> createState() =>
      _PasswordCustomTextFieldState();
}

class _PasswordCustomTextFieldState extends State<PasswordCustomTextField> {
  bool isSafe = true;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.heading.text
              .size(14)
              .color(buttonBorderColor)
              .fontFamily(regular)
              .make(),
          5.heightBox,
          TextFormField(
            style:
                TextStyle(color: whiteColor, fontFamily: medium, fontSize: 14),
            initialValue: widget.initialValue,
            controller: widget.textEditingController,
            readOnly: widget.readOnly,
            obscureText: isSafe,
            validator: widget.validator,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade700,
              filled: true,
              hintText: widget.textLabel,
              prefixIcon: widget.icon,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isSafe = !isSafe;
                        });
                      },
                      icon: Icon(isSafe
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined)),
                  widget.suffixIcon1 ?? const SizedBox(),
                  widget.suffixIcon2 ?? const SizedBox(),
                ],
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: buttonBorderColor),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget customTextfield(
    {required String heading,
    Icon? icon,
     TextInputType? textInputType,
    required String textLabel,
    IconButton? suffixIcon1,
    IconButton? suffixIcon2,
    String? Function(String?)? validator,
    String? prefixText,
    bool readOnly = false,
    String? initialValue,
    TextEditingController? textEditingController}) {
  return Flexible(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading.text
            .size(14)
            .color(buttonBorderColor)
            .fontFamily(regular)
            .make(),
        5.heightBox,
        TextFormField(
          initialValue: initialValue,
          controller: textEditingController,
          readOnly: readOnly,
          validator: validator,
          keyboardType: textInputType,
          //  obscureText: isSafe,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade700, // Set the background color here
            hintText: textLabel,
            //hintStyle: TextStyle(color: darkFontGrey),
            prefixIcon: icon,
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                suffixIcon1 ?? const SizedBox(),
                suffixIcon2 ?? const SizedBox(),
              ],
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: AppColor.whiteColor),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    ),
  ));
}

/*
    );
  }
}

Widget customTextfield({
  required String heading,
  Icon? icon,
  required String textLabel,
  IconButton? suffixIcon1,
  IconButton? suffixIcon2,
  String? prefixText,
  bool readOnly = false,
  String? initialValue,
  TextEditingController? textEditingController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      heading.text.bold.make(),
      5.heightBox,
      TextFormField(
        initialValue: initialValue,
        controller: textEditingController,
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Set the background color here
          hintText: textLabel,
          prefixIcon: icon,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              suffixIcon1 ?? const SizedBox(),
              suffixIcon2 ?? const SizedBox(),
            ],
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ), 
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColor.whiteColor),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ],
  );
}
*/

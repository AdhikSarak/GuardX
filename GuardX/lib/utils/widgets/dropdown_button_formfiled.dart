// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:guardx/consts/index.dart';

/*
Widget dropdownButtonFormField({required String heading,
    Icon? icon,
    required String textLabel,
    IconButton? suffixIcon1,
    IconButton? suffixIcon2,
    String? prefixText,
    bool readOnly = false,
    String? initialValue,
    TextEditingController? textEditingController}) {
      /*
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      heading.text.size(14).color(buttonBorderColor).fontFamily(regular).make(),
      5.heightBox,
      DropdownButtonFormField(   
        items: debitCreditCardList,   
        //onChanged: () {},  
        style: TextStyle(color: whiteColor, fontFamily: medium, fontSize: 14),
        //initialValue: initialValue,
        //controller: textEditingController,
        //readOnly: readOnly,
        decoration: InputDecoration(
          //constraints: BoxConstraints(maxHeight: 45),
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 13),
          fillColor: textfieldGrey,
          filled: true,
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
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: buttonBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ), onChanged: (value) {  },
      )
    ],
  ); 
  return InputDecorator(
              decoration: InputDecoration(
                  //labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              //isEmpty: _currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  //value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _currentSelectedValue = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );*/

}
*/
class DropdownButtonFormfiled extends StatefulWidget {
  final String heading;
  String? value;
  List<DropdownMenuItem<String>> items;
  Icon? icon;
  String textLabel;
  IconButton? suffixIcon1;
  IconButton? suffixIcon2;
  String? prefixText;
  bool isPass = false;
  bool readOnly = false;
  String? initialValue;
  TextEditingController? textEditingController;
  DropdownButtonFormfiled({
    Key? key,
    required this.heading,
    this.value,
    required this.items,
    this.icon,
    required this.textLabel,
    this.suffixIcon1,
    this.suffixIcon2,
    this.prefixText,
    required this.isPass,
    required this.readOnly,
    this.initialValue,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<DropdownButtonFormfiled> createState() =>
      _DropdownButtonFormfiledState();
}

class _DropdownButtonFormfiledState extends State<DropdownButtonFormfiled> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.heading.text
              .size(14)
              .color(buttonBorderColor)
              .fontFamily(regular)
              .make(),
          5.heightBox,
          DropdownButtonFormField(
            //value: widget.items[0].value,
            value: widget.value,
            items: widget.items,
            style:
                TextStyle(color: whiteColor, fontFamily: medium, fontSize: 14),
            //initialValue: initialValue,
            //controller: textEditingController,
            //readOnly: readOnly,
            decoration: InputDecoration(
              //constraints: BoxConstraints(maxHeight: 45),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 13),
              fillColor: textfieldGrey,
              filled: true,
              hintText: widget.textLabel,
              alignLabelWithHint: true,
              prefixIcon: widget.icon,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
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
            onChanged: (value) {
              setState(() {
                widget.textEditingController?.text = value!;
              });
            },
          )
        ],
      ),
    );
  }
}

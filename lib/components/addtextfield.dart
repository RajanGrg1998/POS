import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  final String hintText;
  final String? validateText;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const AddTextField({
    Key? key,
    required this.hintText,
    this.textEditingController,
    this.validateText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE0E0E0)),
        ),
        hintText: hintText,
        //labelText: 'Enter the Value',
        errorText: validateText,
      ),
      onChanged: onChanged,
    );
  }
}

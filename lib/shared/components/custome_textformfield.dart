import 'package:flutter/material.dart';

class CustomeTextformfield extends StatelessWidget {
   CustomeTextformfield({Key? key,required this.controller,required this.prefixIcon,required this.hintText,required this.labelText,this.inputType,this.suffixIcon,this.suffixPressed,this.isObscure = false}) : super(key: key);
TextEditingController controller;
String hintText,labelText;
IconData prefixIcon;
IconData? suffixIcon;
TextInputType? inputType;
bool isObscure;
VoidCallback? suffixPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isObscure,
      validator: (data){
        if(controller.text.isEmpty){
          return '$hintText field is required';
        }else{
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        ),
      ),
    );
  }
}

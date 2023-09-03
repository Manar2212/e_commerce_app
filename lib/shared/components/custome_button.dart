

import 'package:flutter/material.dart';
import '../../shared/constants/constants.dart';

class CustomeButton extends StatelessWidget {
   CustomeButton({Key? key,required this.widget,required this.function}) : super(key: key);

   Widget widget;
   VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed:function,
      child: widget,
      padding: EdgeInsets.all(15),
      minWidth: double.infinity,
      color: mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

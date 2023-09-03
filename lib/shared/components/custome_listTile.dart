import 'package:flutter/material.dart';

import '../../shared/constants/constants.dart';

class CustomeListTile extends StatelessWidget {
   CustomeListTile({Key? key,required this.title,required this.icon,required this.onTap}) : super(key: key);
   String title;
   IconData icon;
   VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: thirdColor,
      ),
      child: ListTile(
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: fifthColor),),
        leading: Icon(icon,color: mainColor),
        iconColor: secondColor,
        trailing: GestureDetector(child: Icon(Icons.arrow_forward_ios_outlined),
        onTap: onTap,
        ),
      ),
    );
  }
}

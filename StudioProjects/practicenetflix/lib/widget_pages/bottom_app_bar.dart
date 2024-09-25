import 'package:flutter/material.dart';

Widget navBarItem(BuildContext context,IconData icon,String label,int index,Function(int) onTap){
    return InkWell(
      onTap:() =>onTap(index) ,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          Text(label),
        ],
      ),
    );
  }



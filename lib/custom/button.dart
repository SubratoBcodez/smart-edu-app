import 'package:flutter/material.dart';

Widget customButton(title,onTap){
  return InkWell(
    onTap: onTap,
    splashColor: Colors.greenAccent,
    borderRadius: BorderRadius.circular(8),
    child: Ink(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green
      ),
      child: Center(
        child: Text(title,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),),
      ),
    ),
  );
}
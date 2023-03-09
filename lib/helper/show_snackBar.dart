
import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    backgroundColor: kPrimaryColor,
    closeIconColor: Colors.red,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(Icons.error,color: Colors.red,),
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
        ),
      ],
    ),
  ));
}
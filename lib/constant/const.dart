// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/constant/style/icon_broken.dart';

// للتتقال للصفحة التاليه بسهولة
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinash(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseTheColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// to choose the color for toast we neede the enum
enum ToastStates {
  SUCSSES,
  ERROR,
  WORNING,
}

// the methodde to chooose the color for the tost
Color chooseTheColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCSSES:
      color = Colors.green;
      break;
    case ToastStates.WORNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

// ده علشان اقدر احصل علي المتغير ده في كل الصفحات
String uId = '';
String tocken = '';

// default button
Widget defaultButton({
  required String title,
  required Color buttonColor,
  required function,
}) {
  return Container(
    height: 40.0,
    width: double.infinity,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),
      ),
    ),
  );
}

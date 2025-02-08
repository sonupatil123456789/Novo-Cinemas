import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class ListnersUtils {
  static void showErrorMessage(String message, String title, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          title: title,
          message: message,
          flushbarPosition: FlushbarPosition.BOTTOM,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          // forwardAnimationCurve: Curves.decelerate,
          backgroundColor: Colors.redAccent,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          titleText: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          messageText: Text(
            message,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        )..show(context));
  }

  static void showSuccessMessage(String message,String title, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          title: title,
          message: message,
          flushbarPosition: FlushbarPosition.BOTTOM,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          // forwardAnimationCurve: Curves.decelerate,
          backgroundColor: Colors.greenAccent,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          titleText: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          messageText: Text(
            message,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        )..show(context));
  }


}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void botToast(String title,
    {int second = 10,
    double? fontSize,
    double alignX = 0,
    double alignY = 0.99}) {
  BotToast.showNotification(
    onlyOne: true,
    dismissDirections: [DismissDirection.horizontal, DismissDirection.down],
    // backgroundColor: Colors.primaryColor,
    align: Alignment(alignX, alignY),
    duration: Duration(seconds: second),
    animationDuration: const Duration(milliseconds: 200),
    animationReverseDuration: const Duration(milliseconds: 200),
    // leading: (_) => Image.asset((assets..shuffle()).first, height: 25),
    title: (_) => Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        // color: Colors.white,
      ),
    ),
  );
}

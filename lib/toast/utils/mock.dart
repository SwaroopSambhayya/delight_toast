import 'package:delightful_toast/toast/components/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

List demoToastBars = [
  DelightToastBar(
    autoDismiss: false,
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: Text(
        "Hi I'm Dash, Let's have a walkthrough of Delight Toast",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ),
  DelightToastBar(
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: Text(
        "Delight Toast is interactive!",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ),
  DelightToastBar(
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: Text(
        "Toast is removable on swipe!",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ),
  DelightToastBar(
    autoDismiss: false,
    builder: (context) => ToastCard(
      leading: const Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      trailing: IconButton(
          onPressed: () {
            DelightToastBar.removeAll();
          },
          icon: const Icon(Icons.close)),
      title: const Text(
        "Toast is removable on action!",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ),
  DelightToastBar(
    autoDismiss: true,
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      title: Text(
        "Toast is auto dismissable if you are lazy enough!",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ),
  DelightToastBar(
    builder: (context) => const ToastCard(
      leading: Icon(
        Icons.flutter_dash,
        size: 28,
      ),
      subtitle: Text("You can add subtitle"),
      title: Text(
        "You can add title",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
  ),
];

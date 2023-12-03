import 'package:delightful_toast/toast/components/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DelightToast extends StatefulWidget {
  const DelightToast({super.key});

  @override
  State<DelightToast> createState() => _DelightToastState();
}

class _DelightToastState extends State<DelightToast> {
  bool onClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
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
            );
            setState(() {
              onClicked = true;
            });
            await Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                onClicked = false;
              });
            });
          },
          child: const Text(
            "TOAST!",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ).animate(target: onClicked ? 1 : 0).scaleXY(
              begin: 1,
              end: 0.94,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 100),
            ),
      ),
    );
  }
}

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A delighful and very interactive toast or a snackbar to add more delight to your application

https://github.com/SwaroopSambhayya/delight_toast/assets/31922733/45b77a2e-7a73-44a0-899d-8d2f740097fb

## Features

1. Trigger a toastbar
2. Slide to dismiss a toastbar
3. Auto dimiss a toastbar
4. Dismiss on demand via action buttons
5. Stacking a toasbar in a delightful way!

## Getting started

```dart
// add the import statement
import 'package:delightful_toast';

```

## Usage

Use the toasbar whenever a event has been triggered like onPressed/onTapped or in any other situation where the event is enforced

```dart
ElevatedButton( onPressed:(){
     DelightToastBar(
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
            ).show(context);

},
     child: const Text("Toast!")
)
```

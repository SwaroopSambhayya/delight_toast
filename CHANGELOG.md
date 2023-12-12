## 1.0.0

Initial features for Delight toast bar has been added!

## 1.0.1

Adding the documentation changes

## 1.0.2

Adding description with detail in pubspec

## 1.1.0

Minor bugfixes

## 1.2.0

- Fixed a bug where multiple toasts weren't displaying correctly until the user touched the screen.
- Added static functions `removeLast` and `removeFirst` to remove the last or first toast on the stack.
- Introduced the `removeWithKey` function to remove a toast with a specified key.
- Included the `toastInfo` property in the `DelightToast` constructor for precise control over toast removal using the `removeWithKey` function.
- Implemented the `DelightToast.generateInfo()` static function to assist in generating toast information.


/// Name of the library
library delightful_toast;

import 'package:delightful_toast/toast/components/raw_delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:delightful_toast/toast/utils/utils.dart';
import 'package:flutter/material.dart';

List<DelightToastBar> _toastBars = [];

/// Delight Toast core class
class DelightToastBar {
  /// Duration of toast when autoDismiss is true
  final Duration snackbarDuration;

  /// Position of toast
  final DelightSnackbarPosition position;

  /// Set true to dismiss toast automatically based on snackbarDuration
  final bool autoDismiss;

  /// Pass the widget inside builder context
  final WidgetBuilder builder;

  /// Duration of animated transitions
  final Duration animationDuration;

  /// Animation Curve
  final Curve? animationCurve;

  /// Info on each snackbar
  final SnackBarInfo info;

  /// Initialise Delight Toastbar with required parameters
  DelightToastBar(
      {this.snackbarDuration = const Duration(milliseconds: 5000),
      this.position = DelightSnackbarPosition.bottom,
      required this.builder,
      this.animationDuration = const Duration(milliseconds: 700),
      this.autoDismiss = false,
      this.animationCurve,
      required this.info})
      : assert(
            snackbarDuration.inMilliseconds > animationDuration.inMilliseconds);

  /// Remove individual toastbars on dismiss
  void remove() {
    info.entry.remove();
    _toastBars.removeWhere((element) => element == this);
  }

  /// Push the snackbar in current context
  void show(BuildContext context) {
    OverlayState overlayState = Navigator.of(context).overlay!;

    info.entry = OverlayEntry(
      builder: (_) => RawDelightToast(
        key: info.key,
        animationDuration: animationDuration,
        snackbarPosition: position,
        animationCurve: animationCurve,
        autoDismiss: autoDismiss,
        getPosition: () => calculatePosition(_toastBars, this),
        getscaleFactor: () => calculateScaleFactor(_toastBars, this),
        snackbarDuration: snackbarDuration,
        onRemove: remove,
        child: builder.call(context),
      ),
    );

    _toastBars.add(this);
    overlayState.insert(info.entry);
  }

  // * Static helpers
  static SnackBarInfo generateInfo() {
    return SnackBarInfo(
        key: GlobalKey<RawDelightToastState>(), createdAt: DateTime.now());
  }

  /// Remove all the snackbar in the context
  static void removeAll() {
    for (int i = 0; i < _toastBars.length; i++) {
      _toastBars[i].info.entry.remove();
    }
    _toastBars.removeWhere((element) => true);
  }

  /// Remove the last toast on top of the snackbar stack
  static void removeLast() {
    _toastBars.last.info.entry.remove();
    _toastBars.removeLast();
  }

  /// Remove the oldest toast on the bottom of the snackbar stack
  static void removeFirst() {
    _toastBars.first.info.entry.remove();
    _toastBars.first.remove();
  }

  /// Remove with key
  static void removeWithKey(GlobalKey<RawDelightToastState> key) {
    for (int i = 0; i < _toastBars.length; i++) {
      if (_toastBars[i].info.key == key) {
        _toastBars[i].info.entry.remove();
        _toastBars.removeAt(i);
        break;
      }
    }
  }
}

/// Snackbar info class
class SnackBarInfo {
  late final OverlayEntry entry;
  final GlobalKey<RawDelightToastState> key;
  final DateTime createdAt;

  SnackBarInfo({required this.key, required this.createdAt});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SnackBarInfo &&
        other.entry == entry &&
        other.key == key &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => entry.hashCode ^ key.hashCode ^ createdAt.hashCode;
}

/// Get all the toastbars which currenlty on context
extension Cleaner on List<DelightToastBar> {
  /// clean function to iterate over toastbars which are in context
  List<DelightToastBar> clean() {
    return where((element) => element.info.key.currentState != null).toList();
  }
}

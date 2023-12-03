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
  final Curve animationCurve;

  /// Info on each snackbar
  late final SnackBarInfo info;

  DelightToastBar(
      {this.snackbarDuration = const Duration(milliseconds: 5000),
      this.position = DelightSnackbarPosition.bottom,
      required this.builder,
      this.animationDuration = const Duration(milliseconds: 700),
      this.autoDismiss = false,
      this.animationCurve = Curves.bounceInOut})
      : assert(
            snackbarDuration.inMilliseconds > animationDuration.inMilliseconds);

  void remove() {
    info.entry.remove();
    _toastBars.removeWhere((element) => element == this);
  }

  /// Push the snackbar in current context
  void show(BuildContext context) {
    OverlayState overlayState = Navigator.of(context).overlay!;
    info = SnackBarInfo(
      key: GlobalKey<RawDelightToastState>(),
      createdAt: DateTime.now(),
    );
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _toastBars.add(this);
      overlayState.insert(info.entry);
    });
  }

  /// Remove all the snackbar in the context
  static void removeAll() {
    for (int i = 0; i < _toastBars.length; i++) {
      _toastBars[i].info.entry.remove();
    }
    _toastBars.removeWhere((element) => true);
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

extension Cleaner on List<DelightToastBar> {
  List<DelightToastBar> clean() {
    return where((element) => element.info.key.currentState != null).toList();
  }
}

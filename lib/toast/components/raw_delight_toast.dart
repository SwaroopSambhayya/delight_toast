import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RawDelightToast extends StatefulWidget {
  final Widget child;
  final Duration animationDuration;
  final Duration snackbarDuration;
  final Curve? animationCurve;
  final bool autoDismiss;
  final DelightSnackbarPosition snackbarPosition;
  final Function() getscaleFactor;
  final Function() getPosition;

  final Function() onRemove;
  const RawDelightToast(
      {super.key,
      required this.child,
      required this.animationDuration,
      required this.snackbarPosition,
      required this.snackbarDuration,
      required this.onRemove,
      this.autoDismiss = true,
      required this.getPosition,
      this.animationCurve,
      required this.getscaleFactor});

  @override
  State<RawDelightToast> createState() => RawDelightToastState();
}

class RawDelightToastState extends State<RawDelightToast> {
  final GlobalKey positionedKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Widget getChildBasedOnDissmiss(Widget child) {
    return Animate(
      onComplete: (controller) {
        if (widget.autoDismiss) {
          widget.onRemove();
        }
      },
      effects: [
        SlideEffect(
            begin: Offset(
                0,
                widget.snackbarPosition == DelightSnackbarPosition.bottom
                    ? 2
                    : -2),
            end: Offset.zero,
            duration: Duration(
                milliseconds: 2 * widget.animationDuration.inMilliseconds),
            curve: widget.animationCurve ?? Curves.elasticOut),
        FadeEffect(duration: widget.animationDuration, begin: 0, end: 1),
        if (widget.autoDismiss)
          SlideEffect(
            delay: widget.snackbarDuration,
            duration: const Duration(milliseconds: 500),
            curve: widget.animationCurve ?? Curves.easeInOut,
            begin: Offset.zero,
            end: const Offset(-1, 0),
          )
      ],
      child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            widget.onRemove();
          },
          child: widget.child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: widget.animationDuration.inMilliseconds),
      key: positionedKey,
      curve: Curves.easeOutBack,
      top: widget.snackbarPosition == DelightSnackbarPosition.top
          ? widget.getPosition() + 70
          : null,
      bottom: widget.snackbarPosition == DelightSnackbarPosition.bottom
          ? widget.getPosition() + 70
          : null,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedScale(
          duration: widget.animationDuration,
          curve: Curves.bounceOut,
          scale: widget.getPosition() == 0 ? 1 : widget.getscaleFactor(),
          child: getChildBasedOnDissmiss(widget.child),
        ),
      ),
    );
  }
}

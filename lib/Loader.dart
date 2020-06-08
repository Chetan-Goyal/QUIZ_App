import 'package:flutter/material.dart';
import 'dart:math';

class FlipLoader extends StatefulWidget {
  FlipLoader();

  @override
  _FlipLoaderState createState() => _FlipLoaderState();
}

class _FlipLoaderState extends State<FlipLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotationHorizontal;
  Animation<double> rotationVertical;
  Color loaderColor = Colors.redAccent;
  Widget loaderIconChild;
  final Color iconColor = Colors.white;
  final IconData icon = Icons.sync;
  final String animationType = "full_flip";
  final String shape = "square";
  final bool rotateIcon = true;

  _FlipLoaderState();

  @override
  void initState() {
    super.initState();

    controller = createAnimationController();

    controller.addStatusListener((status) {
      // Play animation backwards and forwards for full flip
      if (status == AnimationStatus.dismissed) {
        setState(() {
          controller.forward();
        });
      }
      if (status == AnimationStatus.completed) {
        setState(() {
          controller.repeat();
        });
      }
    });

    controller.forward();
  }

  AnimationController createAnimationController() {
    AnimationController animCtrl;

    animCtrl = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    this.rotationHorizontal = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animCtrl,
            curve: Interval(0.0, 0.50, curve: Curves.linear)));
    this.rotationVertical = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animCtrl,
            curve: Interval(0.50, 1.0, curve: Curves.linear)));

    return animCtrl;
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          child: new Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.006)
              ..rotateX((2 * pi * rotationVertical.value))
              ..rotateY((2 * pi * rotationHorizontal.value)),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                shape: shape == "circle" ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: shape == "circle"
                    ? null
                    : new BorderRadius.all(const Radius.circular(8.0)),
                color: loaderColor,
              ),
              width: 40.0,
              height: 40.0,
              child: new Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedTarget extends StatefulWidget {
  _AnimatedTargetState createState() {
    return _AnimatedTargetState();
  }
}

class _AnimatedTargetState extends State<AnimatedTarget>
    with TickerProviderStateMixin {
  Animation<double> targetAnimation;
  AnimationController targetController;

  initState() {
    super.initState();

    targetController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    targetAnimation = Tween(
      begin: 0.0,
      end: 10.0,
    ).animate(
      CurvedAnimation(
        parent: targetController,
        curve: Curves.linear,
      ),
    );

    targetController.forward();

    targetAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        targetController.repeat();
      }
    });
  }

  dispose() {
    targetController.dispose();
    super.dispose();
  }

  buildTargetAnimation() {
    return AnimatedBuilder(
      animation: targetAnimation,
      builder: (context, child) {
        Size screen = MediaQuery.of(context).size;
        double targetSize = 50;
        double top = (screen.height * 0.4) - (targetSize / 2);
        return Positioned(
          top: top - (targetAnimation.value / 2),
          child: Container(
            height: targetSize + targetAnimation.value,
            width: targetSize + targetAnimation.value,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: Colors.green,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
        );

        // return Container(
        //   height: targetSize + targetAnimation.value,
        //   width: targetSize + targetAnimation.value,
        //   decoration: new BoxDecoration(
        //     shape: BoxShape.circle,
        //     border: new Border.all(
        //       color: Colors.green,
        //       width: 2.0,
        //       style: BorderStyle.solid,
        //     ),
        //   ),
        // );
      },
    );
  }

  Widget build(BuildContext context) {
    // return Container(
    //   height: 75.0,
    //   decoration: new BoxDecoration(
    //     shape: BoxShape.circle,
    //     border: new Border.all(
    //       color: Colors.green,
    //       width: 2.0,
    //       style: BorderStyle.solid,
    //     ),
    //   ),
    // );
    return buildTargetAnimation();
  }
}

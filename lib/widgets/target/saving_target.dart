import 'package:flutter/material.dart';
import 'package:animal_id/widgets/target/pulse.dart';

class SavingTarget extends StatefulWidget {
  _SavingTargetState createState() {
    return _SavingTargetState();
  }
}

class _SavingTargetState extends State<SavingTarget>
    with TickerProviderStateMixin {
  Animation<double> targetAnimation;
  AnimationController targetController;

  initState() {
    super.initState();

    targetController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );

    targetAnimation = Tween(
      begin: 0.0,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: targetController,
        curve: Curves.linear,
      ),
    );

    targetController.forward();

    // targetAnimation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     targetController.repeat();
    //   }
    // });
  }

  dispose() {
    targetController.dispose();
    super.dispose();
  }

  buildTargetAnimation() {
    double value = targetAnimation.value;
    return AnimatedBuilder(
      animation: targetAnimation,
      builder: (context, child) {
        Size screen = MediaQuery.of(context).size;
        double targetSize = 50;
        double top = (screen.height * 0.4) - (targetSize / 2);
        // double opacityValue = (50.0 - value) / 50.0;
        return Positioned(
          top: top - (value / 2),
          child: Container(
            height: targetSize + value,
            width: targetSize + value,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: Colors.green.withOpacity(0.5),
                width: 10.0,
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

import 'package:flutter/material.dart';

class SlidingAnimationText extends StatelessWidget {
  const SlidingAnimationText({
    super.key,
    required this.slideTransitionAnimation,
  });

  final Animation<Offset> slideTransitionAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // AnimatedBuilder مسؤولة عن بناء ال animation وبت rebuild ال return بتاعها
      animation: slideTransitionAnimation,
      builder: (context, _) {
        // _   : بمعني مش هنستخدمها
        return SlideTransition(
          position: slideTransitionAnimation,
          child: const Text(
            'Enjoy Readying With Free Books',
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
            textScaler: TextScaler.linear(0.90),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AgendadorLoader extends StatelessWidget {
  const AgendadorLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: Colors.deepPurpleAccent,
        secondRingColor: Colors.pinkAccent,
        thirdRingColor: Colors.lightBlueAccent,
        size: 55,
      ),
    );
  }
}

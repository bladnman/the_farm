import 'package:flutter/material.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';
import 'package:the_farm/widgets/playground/ActorLayer.dart';

class Playground extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final List<BaseActor> actors;

  Playground({
    this.color,
    this.width,
    this.height,
    this.actors,
  });

  @override
  Widget build(BuildContext context) {
    double finalWidth = this.width ?? 100;
    double finalHeight = this.height ?? 100;
    return SizedBox(
      width: finalWidth ?? 100,
      height: finalHeight ?? 100,
      child: Stack(children: [
        // background
        Container(
          color: this.color,
          width: finalWidth,
          height: finalHeight,
        ),
        // actors
        ActorLayer(
          actors: actors,
          width: finalWidth,
          height: finalHeight,
        ),
      ]),
    );
  }
}

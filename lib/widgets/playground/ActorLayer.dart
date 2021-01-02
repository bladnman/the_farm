import 'package:flutter/material.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

class ActorLayer extends StatelessWidget {
  final List<BaseActor> actors;
  final double width;
  final double height;
  ActorLayer({
    this.actors,
    this.width,
    this.height,
  });
  List<Widget> get alignedActors {
    if (actors == null || actors.length < 1) {
      return null;
    }
    // return a list of containers wrapping our actors
    return List.generate(actors.length, (int index) {
      BaseActor actor = actors[index];
      return Positioned(
        left: width * actor.xPercFloat,
        top: height * actor.yPercFloat,
        child: Container(
          decoration: BoxDecoration(
            color: actor.color ?? Colors.white60,
            borderRadius: BorderRadius.all(
              Radius.circular(actor.size / 2),
            ),
          ),
          height: actor.size,
          width: actor.size,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: alignedActors);
  }
}

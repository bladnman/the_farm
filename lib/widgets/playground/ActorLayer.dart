import 'package:flutter/material.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

class ActorLayer extends StatelessWidget {
  final List<BaseActor> actors;
  final double width;
  final double height;
  final bool showOverlays;
  ActorLayer({
    this.actors,
    this.width,
    this.height,
    this.showOverlays = true,
  });
  List<Widget> get alignedActors {
    if (actors == null || actors.length < 1) {
      return null;
    }
    // return a list of containers wrapping our actors
    return List.generate(actors.length, (int index) {
      BaseActor actor = actors[index];
      double halfSize = actor.size / 2;
      return Positioned(
        left: actor.position.dx - halfSize,
        top: actor.position.dy - halfSize,
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

  List<Widget> get actorOverlays {
    if (actors == null || actors.length < 1) {
      return null;
    }
    // return a list of containers wrapping our actors
    return List.generate(actors.length, (int index) {
      BaseActor actor = actors[index];
      return Positioned(
        left: actor.position.dx + actor.size,
        top: actor.position.dy - (actor.size),
        child: getInfoForActor(actor),
      );
    });
  }

  Widget getInfoForActor(BaseActor actor) {
    if (actor == null) {
      return Container();
    }
    return Column(
      children: [
        Row(
          children: [
            Transform.rotate(
              angle: actor.heading ?? 0,
              child: Image(
                image: AssetImage('assets/up-arrow-plain.png'),
                width: 10,
                height: 10,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              actor.velocity.toString(),
              style: TextStyle(
                color: actor.color ?? Colors.white60,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          actor.position.dx.toString() + ', ' + actor.position.dy.toString(),
          style: TextStyle(
            color: actor.color ?? Colors.white60,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> kids = [];
    kids.addAll(alignedActors);

    if (this.showOverlays) {
      kids.addAll(actorOverlays);
    }

    return Stack(children: kids);
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_farm/utils/math_utils.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

const Color CURRENT_ACTOR_COLOR = Color(0xffffaa00);
const Color NEXT_ACTOR_COLOR = Color(0x55aaaa00);

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
      return circle(
        actor.position.dx,
        actor.position.dy,
        actor.color,
        actor.size,
      );
    });
  }

  Widget circle(x, y, color, size) {
    return Positioned(
      left: x - size / 2,
      top: y - size / 2,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? CURRENT_ACTOR_COLOR,
          borderRadius: BorderRadius.all(
            Radius.circular(size / 2),
          ),
        ),
        height: size,
        width: size,
      ),
    );
  }

  List<Widget> get actorOverlays {
    if (actors == null || actors.length < 1) {
      return null;
    }
    // return a list of containers wrapping our actors
    return List.generate(actors.length, (int index) {
      BaseActor actor = actors[index];
      return Positioned(
        left: actor.position.dx + (actor.size / 2),
        top: actor.position.dy - (actor.size / 2),
        child: getInfoForActor(actor),
      );
    });
  }

  List<Widget> get actorNextSteps {
    if (actors == null || actors.length < 1) {
      return null;
    }
    // return a list of containers wrapping our actors
    return List.generate(actors.length, (int index) {
      BaseActor actor = actors[index];
      return getNextStepForActor(actor);
    });
  }

  Widget getNextStepForActor(BaseActor actor) {
    double newX = nextXForActor(actor).toInt().toDouble();
    double newY = nextYForActor(actor).toInt().toDouble();

    return circle(
      newX,
      newY,
      NEXT_ACTOR_COLOR,
      actor.size,
    );
  }

  Widget getInfoForActor(BaseActor actor) {
    if (actor == null) {
      return Container();
    }
    var directionString =
        ' [' + actor.heading.toString() + '-' + actor.directionString + ']';
    return Column(
      children: [
        Row(
          children: [
            Transform.rotate(
              // angle: actor.heading ?? 0,
              angle: convertDegrees2Radians(actor.heading ?? 0),
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
                color: actor.color ?? Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              directionString,
              style: TextStyle(
                color: actor.color ?? Colors.white,
                fontSize: 14,
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
            color: actor.color ?? Colors.white,
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
      kids.addAll(actorNextSteps);
      kids.addAll(actorOverlays);
    }

    return Stack(children: kids);
  }
}

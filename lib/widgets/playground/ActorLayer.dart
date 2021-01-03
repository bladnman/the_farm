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
      return Stack(
        children: [
          Positioned(
            left: actor.position.dx - actor.scale * 0.3,
            top: actor.position.dy - actor.scale * 0.3,
            child: getDirectionArrow(actor: actor, size: actor.scale * 0.6),
          ),
          Positioned(
            left: actor.position.dx + (actor.size / 2),
            top: actor.position.dy - (actor.size / 2),
            child: getInfoForActor(actor),
          ),
        ],
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

  Widget getDirectionArrow(
      {BaseActor actor, double size = 10, Color color = Colors.purple}) {
    return Transform.rotate(
      // angle: actor.heading ?? 0,
      angle: convertDegrees2Radians(actor.heading + 90 ?? 0),
      child: Image(
        image: AssetImage('assets/up-arrow-plain.png'),
        width: size,
        height: size,
        color: color,
      ),
    );
  }

  Widget getInfoForActor(BaseActor actor) {
    if (actor == null) {
      return Container();
    }
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 7,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          actor.directionString,
                          style: TextStyle(
                            color: actor.velocity.dx > 0
                                ? Colors.green
                                : Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          ' / ',
                          style: TextStyle(
                            color: actor.color ?? Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          actor.heading.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          actor.velocity.dx.toString(),
                          style: TextStyle(
                            color: actor.velocity.dx > 0
                                ? Colors.green
                                : Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ', ',
                          style: TextStyle(
                            color: actor.color ?? Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          actor.velocity.dy.toString(),
                          style: TextStyle(
                            color: actor.velocity.dy > 0
                                ? Colors.green
                                : Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
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

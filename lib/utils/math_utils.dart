import 'dart:math';

import 'package:the_farm/widgets/actors/BaseActor.dart';

var rng = new Random();
int rand({int high = 100, int low = 0}) {
  return rng.nextInt(high - low) + low;
}

/// Converts degrees to radians.
double convertDegrees2Radians(double degrees) => degrees * pi / 180.0;

/// Converts radians to degrees.
double convertRadians2Degrees(double radians) => radians * 180.0 / pi;

double nextXForActor(BaseActor actor) {
  double angle = actor.heading;
  if (actor.isHeadingUp && actor.isHeadingRight) {
    // noop
  } else if (actor.isHeadingDown && actor.isHeadingRight) {
    angle -= 90;
  } else if (actor.isHeadingDown && actor.isHeadingLeft) {
    angle -= 180;
  } else if (actor.isHeadingUp && actor.isHeadingLeft) {
    angle -= 270;
  }

  double xAdj = cos(convertDegrees2Radians(angle)) * actor.velocity;
  double newX = actor.position.dx;
  if (actor.isHeadingRight) {
    newX += xAdj;
  } else {
    newX -= xAdj;
  }
  return newX;
}

double nextYForActor(BaseActor actor) {
  double angle = actor.heading;
  if (actor.isHeadingUp && actor.isHeadingRight) {
    // noop
  } else if (actor.isHeadingDown && actor.isHeadingRight) {
    angle -= 90;
  } else if (actor.isHeadingDown && actor.isHeadingLeft) {
    angle -= 180;
  } else if (actor.isHeadingUp && actor.isHeadingLeft) {
    angle -= 270;
  }
  double yAdj = (sin(convertDegrees2Radians(angle)) * actor.velocity);
  double newY = actor.position.dy;
  if (actor.isHeadingDown) {
    newY += yAdj;
  } else {
    newY -= yAdj;
  }
  return newY;
}

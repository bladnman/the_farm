import 'dart:math';

import 'package:the_farm/widgets/actors/BaseActor.dart';

var rng = new Random();
int rand({int high = 100, int low = 0}) {
  return rng.nextInt(1 + high - low) + low;
}

bool isHeads() {
  return roll(2) == 2;
}

int roll(int sided) {
  return rand(high: sided, low: 1);
}

/// Converts degrees to radians.
double convertDegrees2Radians(double degrees) => degrees * pi / 180.0;

/// Converts radians to degrees.
double convertRadians2Degrees(double radians) => radians * 180.0 / pi;

double nextXForActor(BaseActor actor) {
  return actor.x + actor.velocity.dx;
}

double nextYForActor(BaseActor actor) {
  return actor.y + actor.velocity.dy;
}

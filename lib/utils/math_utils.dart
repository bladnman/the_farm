import 'dart:math';

var rng = new Random();
int rand({int high = 100, int low = 0}) {
  return rng.nextInt(high - low) + low;
}

/// Converts degrees to radians.
double convertDegrees2Radians(double degrees) => degrees * pi / 180.0;

/// Converts radians to degrees.
double convertRadians2Degrees(double radians) => radians * 180.0 / pi;

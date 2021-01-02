import 'dart:math';

var rng = new Random();
int rand({int high = 100, int low = 0}) {
  return rng.nextInt(high - low) + low;
}

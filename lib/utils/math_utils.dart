import 'dart:math';

var rng = new Random();
int rand(int high, int low) {
  return rng.nextInt(high - low) + low;
}

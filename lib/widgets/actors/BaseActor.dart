import 'package:flutter/material.dart';

class BaseActor {
  double scale;
  Color color;
  Offset position;
  double heading;
  double velocity;
  BaseActor({
    this.scale,
    this.color,
    this.position,
    this.heading,
    this.velocity,
  });

  double get size {
    return scale;
  }

  String toString() {
    return this.position.toString() + " / scale: " + this.scale.toString();
  }
}

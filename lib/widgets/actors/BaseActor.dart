import 'package:flutter/material.dart';

class BaseActor {
  double scale;
  Color color;
  double xPercFloat;
  double yPercFloat;

  double xSpeedPercFloat;
  double ySpeedPercFloat;
  BaseActor({
    this.scale,
    this.color,
    this.xPercFloat,
    this.yPercFloat,
    this.xSpeedPercFloat,
    this.ySpeedPercFloat,
  });

  double get size {
    return scale;
  }
}

import 'package:flutter/material.dart';

class BaseActor {
  double scale;
  Color color;
  double xPercFloat;
  double yPercFloat;
  double heading;
  double speedPercSec;
  BaseActor({
    this.scale,
    this.color,
    this.xPercFloat,
    this.yPercFloat,
    this.heading,
    this.speedPercSec,
  });

  double get size {
    return scale;
  }
}

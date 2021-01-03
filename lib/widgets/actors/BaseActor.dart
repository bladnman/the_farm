import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_farm/utils/math_utils.dart';

class BaseActor {
  double scale;
  Color color;
  Offset position;
  Offset velocity;
  double heading;

  BaseActor({
    this.scale,
    this.color,
    this.velocity,
    this.position,
  }) {
    _calculateHeading();
  }

  void setVelocity(Offset velocity) {
    this.velocity = velocity;
    _calculateHeading();
  }

  void _calculateHeading() {
    var rad = atan2(velocity.dy, velocity.dx);
    var newHeading = convertRadians2Degrees(rad);
    if (newHeading < 0) {
      newHeading = (360.0 + newHeading);
    }
    this.heading = newHeading.floorToDouble();
  }

  double get size {
    return scale;
  }

  bool get isHeadingRight {
    return heading >= 270 || heading <= 90;
  }

  bool get isHeadingLeft {
    return !isHeadingRight;
  }

  bool get isHeadingDown {
    return heading >= 0 && heading <= 180;
  }

  bool get isHeadingUp {
    return !isHeadingDown;
  }

  double get x {
    return this.position.dx;
  }

  double get y {
    return this.position.dy;
  }

  Rect get rect {
    return Rect.fromLTRB(
      position.dx,
      position.dy,
      position.dx + size,
      position.dy + size,
    );
  }

  String get directionString {
    var directionString = '';
    if (isHeadingRight) directionString += 'R';
    if (isHeadingLeft) directionString += 'L';
    if (isHeadingUp) directionString += 'U';
    if (isHeadingDown) directionString += 'D';
    return directionString;
  }

  String toString() {
    var out = 'BaseActor: ';
    out += 'pos=(' + this.x.toString() + ', ' + this.y.toString() + '); ';
    out += 'scale=' + this.scale.toString() + '; ';
    out += 'dir=' + this.directionString + '; ';
    out += 'vel=' + this.velocity.toString() + '; ';
    return out;
  }
}

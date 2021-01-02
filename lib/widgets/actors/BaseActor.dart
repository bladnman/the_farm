import 'package:flutter/material.dart';

class BaseActor {
  double scale;
  Color color;
  double heading;
  double velocity;
  Offset position;

  BaseActor({
    this.scale,
    this.color,
    this.heading,
    this.velocity,
    this.position,
  });

  double get size {
    return scale;
  }

  bool get isHeadingRight {
    return heading >= 0 && heading <= 180;
  }

  bool get isHeadingLeft {
    return !isHeadingRight;
  }

  bool get isHeadingDown {
    return heading >= 90 && heading <= 270;
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

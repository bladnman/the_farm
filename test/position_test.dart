import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';
import '../lib/utils/math_utils.dart';

void main() {
  test('Simple Actor', () {
    var actor = BaseActor(
      position: Offset(100, 100),
      heading: 45,
      velocity: 10,
    );
    expect(actor.heading, equals(45));
  });
  test('h0 x stays the same', () {
    var actor = BaseActor(
      position: Offset(100, 100),
      heading: 0,
      velocity: 10,
    );

    expect(actor.x, equals(100));

    double newX = nextXForActor(actor).toInt().toDouble();
    expect(newX, equals(100));
  });
  test('h90 x moves fully', () {
    var actor = BaseActor(
      position: Offset(100, 100),
      heading: 90,
      velocity: 10,
    );

    expect(actor.x, equals(100));

    double newX = nextXForActor(actor).toInt().toDouble();
    expect(newX, equals(110));
  });
  test('h180 x stays the same', () {
    var actor = BaseActor(
      position: Offset(100, 100),
      heading: 180,
      velocity: 10,
    );

    expect(actor.x, equals(100));

    double newX = nextXForActor(actor).toInt().toDouble();
    expect(newX, equals(100));
  });
  test('h270 x updates fully', () {
    var actor = BaseActor(
      position: Offset(100, 100),
      heading: 270,
      velocity: 10,
    );

    expect(actor.x, equals(100));

    double newX = nextXForActor(actor).toInt().toDouble();
    expect(newX, equals(90));
  });
}

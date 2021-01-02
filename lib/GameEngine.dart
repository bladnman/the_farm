import 'package:flutter/material.dart';
import 'package:the_farm/utils/math_utils.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

const SIZE_MAX = 25;
const SIZE_MIN = 8;
const VELOCITY_MAX = 5;
const VELOCITY_MIN = 1;

class GameEngine {
  Function onUpdate;
  List<BaseActor> actors = [];
  Size _size;

  GameEngine({
    this.onUpdate,
  }) {
    _setup();
  }
  void _setup() {
    actors = [];
    // only set up when we have a size
    if (size == null) {
      return;
    }

    for (var i = 0; i < 5; i++) {
      addActor();
    }
    print('[M@][GameEngine] actors $actors');
  }

  void pause() {
    // noop
  }
  void start() {
    // noop
  }
  void update() {
    // updateWallCollisions();

    // go through actors and update their positions, etc
    for (BaseActor actor in actors) {
      actor.position = Offset(actor.position.dx + actor.velocity,
          actor.position.dy + actor.velocity);
    }
  }

  // void updateWallCollisions() {
  //   for (BaseActor actor in actors) {
  //     if (actor.xPercFloat < 0.05 && actor.xPercFloat < 0) {
  //       actor.xPercFloat *= -1;
  //     } else if (actor.xPercFloat > 0.95 && actor.xPercFloat > 0) {
  //       actor.xPercFloat *= -1;
  //     }
  //     if (actor.yPercFloat < 0.05 && actor.yPercFloat < 0) {
  //       actor.yPercFloat *= -1;
  //     } else if (actor.yPercFloat > 0.95 && actor.yPercFloat > 0) {
  //       actor.yPercFloat *= -1;
  //     }
  //   }
  // }

  BaseActor getRandomActor() {
    return BaseActor(
      position: _randPosition(),
      velocity: rand(high: VELOCITY_MAX, low: VELOCITY_MIN) / 1,
      heading: rand(high: 360, low: 1) / 1,
      scale: rand(high: SIZE_MAX, low: SIZE_MIN) / 1,
    );
  }

  void addActor(/* eventaual def */) {
    BaseActor actor = getRandomActor();
    actors.add(actor);
  }

  set size(Size size) {
    // same as before
    if (_size != null &&
        _size.width == size.width &&
        _size.height == size.height) {
      return;
    }
    _size = size;
    _setup();
  }

  Size get size {
    return _size;
  }

  Offset _randPosition() {
    return Offset(_randWidth().toDouble(), _randHeight().toDouble());
  }

  int _randWidth() {
    return rand(high: (size?.width?.toInt() ?? 1) - SIZE_MAX, low: SIZE_MAX);
  }

  int _randHeight() {
    return rand(high: (size?.height?.toInt() ?? 1) - SIZE_MAX, low: SIZE_MAX);
  }
}

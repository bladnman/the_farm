import 'package:flutter/material.dart';
import 'package:the_farm/utils/math_utils.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

const SIZE_MAX = 55;
const SIZE_MIN = 30;
const VELOCITY_MAX = 35;
const VELOCITY_MIN = 7;
const ACTOR_NUMBER = 7;
const HEADING_MIN = 0;
const HEADING_MAX = 90;

// const HEADING_MIN = 180;
// const HEADING_MAX = 270;
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

    for (var i = 0; i < ACTOR_NUMBER; i++) {
      addActor();
    }
  }

  void pause() {
    // noop
  }
  void start() {
    // noop
  }
  void update() {
    /// WALL COLLISIONS
    updateWallCollisions();

    /// ACTOR-TO-ACTOR COLLISIONS
    // todo: all new here... tbd

    /// APPLY MOMENTUM
    for (BaseActor actor in actors) {
      actor.position = Offset(nextXForActor(actor).toInt().toDouble(),
          nextYForActor(actor).toInt().toDouble());
    }
  }

  void updateWallCollisions() {
    print('---- walls:');
    for (BaseActor actor in actors) {
      // touching RIGHT side
      if (actor.isHeadingRight && actor.rect.right >= size.width) {
        actor.setVelocity(Offset(actor.velocity.dx * -1, actor.velocity.dy));
      }
      // touching LEFT side
      else if (actor.isHeadingLeft && actor.rect.left <= 0) {
        actor.setVelocity(Offset(actor.velocity.dx * -1, actor.velocity.dy));
      }
      // touching BOTTOM side
      if (actor.isHeadingDown && actor.rect.bottom >= size.height) {
        print('[M@][GameEngine] hit bottom');
        actor.setVelocity(Offset(actor.velocity.dx, actor.velocity.dy * -1));
      }
      // touching TOP side
      else if (actor.isHeadingUp && actor.rect.top <= 0) {
        actor.setVelocity(Offset(actor.velocity.dx, actor.velocity.dy * -1));
      }
    }
  }

  BaseActor getRandomActor() {
    double vX = rand(high: VELOCITY_MAX, low: VELOCITY_MIN) / 1;
    double vY = rand(high: VELOCITY_MAX, low: VELOCITY_MIN) / 1;
    return BaseActor(
      position: _randPosition(),
      velocity: Offset(isHeads() ? vX : vX * -1, isHeads() ? vY : vY * -1),
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

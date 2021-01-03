import 'package:flutter/material.dart';
import 'package:the_farm/utils/math_utils.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

const SIZE_MAX = 200;
const SIZE_MIN = 80;
const VELOCITY_MAX = 8;
const VELOCITY_MIN = 1;
const VELOCITY_SCALE = 0.5;
const ACTOR_NUMBER = 5;

const List<Color> actorColors = [
  Color(0x99f7f052),
  Color(0x998b2635),
  Color(0x99f28123),
  Color(0x99b4a0e5),
  Color(0x9938726c),
];

// f7f052,8b2635,f28123,b4a0e5,38726c
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
      Color color = actorColors[rand(high: actorColors.length - 1)];
      addActor(color: color);
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
        actor.setVelocity(Offset(actor.velocity.dx, actor.velocity.dy * -1));
      }
      // touching TOP side
      else if (actor.isHeadingUp && actor.rect.top <= 0) {
        actor.setVelocity(Offset(actor.velocity.dx, actor.velocity.dy * -1));
      }
    }
  }

  BaseActor getRandomActor({Color color}) {
    double vX =
        VELOCITY_SCALE * rand(high: VELOCITY_MAX, low: VELOCITY_MIN) / 1;
    double vY =
        VELOCITY_SCALE * rand(high: VELOCITY_MAX, low: VELOCITY_MIN) / 1;
    return BaseActor(
      position: _randPosition(),
      velocity: Offset(isHeads() ? vX : vX * -1, isHeads() ? vY : vY * -1),
      scale: rand(high: SIZE_MAX, low: SIZE_MIN) / 1,
      color: color,
    );
  }

  void addActor({Color color}) {
    BaseActor actor = getRandomActor(color: color);
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

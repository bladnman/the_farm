import 'package:the_farm/utils/math_utils.dart';
import 'package:the_farm/widgets/actors/BaseActor.dart';

class GameEngine {
  Function onUpdate;
  List<BaseActor> actors = [];
  GameEngine({
    this.onUpdate,
  }) {
    _setup();
  }
  void _setup() {
    actors = [];
    for (var i = 0; i < 5; i++) {
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
    updateWallCollisions();

    double pxPerSec = 0.05;
    // go through actors and update their positions, etc
    for (BaseActor actor in actors) {
      actor.xPercFloat += actor.xSpeedPercFloat * pxPerSec;
      actor.yPercFloat += actor.ySpeedPercFloat * pxPerSec;
    }
  }

  void updateWallCollisions() {
    for (BaseActor actor in actors) {
      if (actor.xPercFloat < 0.05 && actor.xPercFloat < 0) {
        actor.xPercFloat *= -1;
      } else if (actor.xPercFloat > 0.95 && actor.xPercFloat > 0) {
        actor.xPercFloat *= -1;
      }
      if (actor.yPercFloat < 0.05 && actor.yPercFloat < 0) {
        actor.yPercFloat *= -1;
      } else if (actor.yPercFloat > 0.95 && actor.yPercFloat > 0) {
        actor.yPercFloat *= -1;
      }
    }
  }

  BaseActor getRandomActor() {
    return BaseActor(
      xPercFloat: rand(high: 100, low: 0) / 100, // 0.0 - 1.0
      yPercFloat: rand(high: 100, low: 0) / 100, // 0.0 - 1.0
      xSpeedPercFloat: (rand(high: 20, low: 0) / 10) - 1, // +1.0 thru -1.0
      ySpeedPercFloat: (rand(high: 20, low: 0) / 10) - 1, // +1.0 thru -1.0
      scale: rand(high: 30, low: 10) / 1,
    );
  }

  void addActor(/* eventaual def */) {
    actors.add(getRandomActor());
  }
}

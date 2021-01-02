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
    for (var i = 0; i < 20; i++) {
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
    // go through actors and update their positions, etc
    for (BaseActor actor in actors) {
      actor.xPercFloat += actor.speedPercSec;
    }
  }

  BaseActor getRandomActor() {
    return BaseActor(
      xPercFloat: rand(100, 0) / 100,
      yPercFloat: rand(100, 0) / 100,
      scale: rand(30, 10) / 1,
      heading: rand(360, 1) / 1,
      speedPercSec: rand(30, 1) / 1000,
    );
  }

  void addActor(/* eventaual def */) {
    actors.add(getRandomActor());
  }
}

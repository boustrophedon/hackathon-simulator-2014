part of hacksim;

class AnimationSystem extends System {
  AnimationSystem(World world) : super(world) {
    components_wanted = new Set.from([Animation,]);
  }

  void initialize() {
  }

  void process_entity(Entity e) {
    var anim = e.get_component(Animation);
    if (anim.progress >= anim.duration.inMilliseconds) {
      if (anim.complete != null) {
        anim.complete(e, world.dt);
      }
      world.remove_entity(e);
    }
    else {
      anim.update(e, world.dt);
      anim.progress+=world.dt;
    }
  }

  // maybe i should call anim.complete here?
  void remove_entity(Entity e) {}
}

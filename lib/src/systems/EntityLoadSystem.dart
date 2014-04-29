part of hacksim;

class EntityLoadSystem extends System {
  EntityLoadSystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    spawn_initial_apis();
  }

  void spawn_initial_apis() {
    for (int i = 0; i<5; i++) {
      Entity e = world.new_entity();
      e.add_component(new Kind('api'));
      e.add_component(new Position(i*60, 0));
      e.add_component(new Selection());
      e.add_to_world();
    }
  }

  void process_entity(Entity entity) {}

}

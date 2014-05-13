part of hacksim;

class EntityLoadSystem extends System {
  EntityLoadSystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    spawn_initial_apis();
    spawn_initial_api_slots();
  }

  void spawn_initial_apis() {
    for (int i = 0; i<5; i++) {
      Entity e = world.new_entity();
      e.add_component(new Kind('api'));
      e.add_component(new Size(40, 40));
      e.add_component(new Position(i*(40+20), 0));
      e.add_component(new Selection());
      e.add_component(new API());
      e.add_to_world();
    }
  }

  void spawn_initial_api_slots() {
    for (int i = 0; i<2; i++) {
      Entity e = world.new_entity();
      e.add_component(new Kind('api slot'));
      e.add_component(new Size(60, 60));
      e.add_component(new Position(40, 100+(40*i)));
      e.add_component(new Selection());
      e.add_component(new APISlot());
      e.add_to_world();
    }

  }

  void process_entity(Entity entity) {}

}

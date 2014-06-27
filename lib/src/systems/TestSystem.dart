part of hacksim;

class TestSystem extends System {
  TestSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);
  }
  void initialize() {
  }

  void process_entity(Entity entity) {}
  void remove_entity(Entity e) {}
}

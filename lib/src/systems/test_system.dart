part of hacksim;

class TestSystem extends System {
  TestSystem(World world) {
    this.world = world;

    Position pos = new Position(1,2);
    components_wanted = new Set.from([Position,]);
    Entity e = world.new_entity();
    e.add_component(pos);
    e.add_to_world();
  }

  void process() {
    print('hi');
    print(entities);
  }
}

part of hacksim;

class TestSystem extends System {
  TestSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);
  }
  void initialize() {
    world.subscribe_event("EntitySelected", handle_select);
  }

  void handle_select(Map event) {
    print(event['entity'].get_component(Kind).kind);
    world.remove_entity(event['entity']);
  }

  void process_entity(Entity entity) {}
  void remove_entity(Entity e) {}
}

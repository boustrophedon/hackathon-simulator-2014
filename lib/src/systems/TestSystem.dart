part of hacksim;

class TestSystem extends System {
  TestSystem(World world) : super(world) {
    components_wanted = null;
  }
  void initialize() {
    world.subscribe_event("KeyDown", handle_keydown);
  }

  void handle_keydown(Map event) {
    KeyboardEvent k = event['KeyboardEvent'];
    if (k.keyCode == KeyCode.SPACE) {
      world.send_event("SpawnEntity", {'type':'recruiter popup'});
    }
  }

  void process_entity(Entity entity) {}
  void remove_entity(Entity e) {}
}

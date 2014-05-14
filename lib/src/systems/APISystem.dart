part of hacksim;

class APISystem extends System {
  Entity current_piece = null;
  int xoffset;
  int yoffset;

  APISystem(World world) : super(world) {
    components_wanted = new Set.from([Position, API]);
  }

  void initialize() {
  }

  void process_entity(Entity e) {}

}

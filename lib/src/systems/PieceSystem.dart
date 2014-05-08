part of hacksim;

class PieceSystem extends System {
  Entity current_piece = null;
  int xoffset;
  int yoffset;

  PieceSystem(World world) : super(world) {
    components_wanted = new Set.from([Position, Selection, Puzzle]);

    world.subscribe_event('EntitySelected', handle_select);
    world.subscribe_event('EntityDeselected', handle_deselect);
    world.subscribe_event('MouseMove', handle_move);
  }

  void initialize() {
  }

  void process_entity(Entity e) {
  }

  void handle_select(Map event) {
    Entity e = event['entity'];
    if (e.has_component(Puzzle)) {
      current_piece = e;
      Position pos = e.get_component(Position);
      xoffset = event['x'] - pos.x;
      yoffset = event['y'] - pos.y;
    }
  }

  void handle_deselect(Map event) {
    if (event['entity'].has_component(Puzzle)) {
      current_piece = null;
    }
  }

  // i feel like this should be somewhere else
  void handle_move(Map event) {
    if (current_piece != null) {
      Position pos = current_piece.get_component(Position);
      pos.x = event['x'] - xoffset;
      pos.y = event['y'] - yoffset;
    }
  }

}

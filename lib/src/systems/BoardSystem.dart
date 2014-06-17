part of hacksim;

class BoardSystem extends System {

  Board board;

  BoardSystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    var loader = world.globaldata['video_assets'];

    Entity board = world.new_entity();
    board.add_component(new Board(world.globaldata['canvas'], loader.videos['hackru']));
    board.add_to_world();

    world.globaldata['board'] = board.get_component(Board);
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

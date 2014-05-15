part of hacksim;

class EntityLoadSystem extends System {
  List<List<int>> colorpool;
  math.Random rng;

  int api_size = 40;
  int api_slot_size = 60;

  EntityLoadSystem(World world) : super(world) {
    components_wanted = null;

    rng = new math.Random();
    colorpool = new List<List<int>>();
  }

  void initialize() {
    for (int i = 0; i<4; i++) {
      colorpool.add(new_random_color());
    }

    spawn_initial_api_slots();
    spawn_initial_apis();
  }

  List<int> new_random_color() {
    List<int> l = new List<int>(3);
    l[0] = rng.nextInt(255);
    l[1] = rng.nextInt(255);
    l[2] = rng.nextInt(255);

    return l;
  }

  List<int> color_from_colorpool() {
    return colorpool[rng.nextInt(colorpool.length-1)];
  }

  void spawn_initial_apis() {
    Board board = world.globaldata['board'];
    for (int i = 0; i<5; i++) {
      int spacing = 20; int offset = 10; int per_row = 5;
      int x = (i%per_row)*(api_size+spacing)+offset;
      int y = (i~/per_row)*(api_size+spacing)+offset;

      Entity e = world.new_entity();
      e.add_component(new Kind('api'));
      e.add_component(new Size(api_size, api_size));
      e.add_component(new Position(x,y));
      e.add_component(new Selection());
      e.add_component(new Draggable());
      e.add_component(new API(color_from_colorpool()));
      e.add_to_world();
    }
  }

  void spawn_initial_api_slots() {
    Board board = world.globaldata['board'];
    for (int i = 0; i<3; i++) {
      int spacing = 30; int offset = 30; int per_row = 3;
      int x = (i%per_row)*(api_slot_size+spacing)+offset;
      int y = (i~/per_row)*(api_slot_size+spacing)+offset +200;

      Entity e = world.new_entity();
      e.add_component(new Kind('api slot'));
      e.add_component(new Size(api_slot_size, api_slot_size));
      e.add_component(new Position(x,y));
      e.add_component(new Selection());
      e.add_component(new Draggable());
      e.add_component(new APISlot(color_from_colorpool()));
      e.add_to_world();
    }

  }

  void process_entity(Entity entity) {}

}

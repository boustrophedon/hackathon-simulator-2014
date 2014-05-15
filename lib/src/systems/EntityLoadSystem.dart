part of hacksim;

class EntityLoadSystem extends System {
  List<List<int>> colorpool;
  math.Random rng;

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
    for (int i = 0; i<5; i++) {
      Entity e = world.new_entity();
      e.add_component(new Kind('api'));
      e.add_component(new Size(40, 40));
      e.add_component(new Position(i*(40+20), 0));
      e.add_component(new Selection());
      e.add_component(new Draggable());
      e.add_component(new API(color_from_colorpool()));
      e.add_to_world();
    }
  }

  void spawn_initial_api_slots() {
    for (int i = 0; i<2; i++) {
      Entity e = world.new_entity();
      e.add_component(new Kind('api slot'));
      e.add_component(new Size(60, 60));
      e.add_component(new Position(40, 100+(80*i)));
      e.add_component(new Selection());
      e.add_component(new Draggable());
      e.add_component(new APISlot(color_from_colorpool()));
      e.add_to_world();
    }

  }

  void process_entity(Entity entity) {}

}

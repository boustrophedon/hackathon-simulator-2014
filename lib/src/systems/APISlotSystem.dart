part of hacksim;

class APISlotSystem extends System {
  
  List<List<int>> colorpool;
  math.Random rng;

  APISlotSystem(World world) : super(world) {
    components_wanted = new Set.from([APISlot,]);

    rng = new math.Random();

    colorpool = new List<List<int>>();
  }

  void initialize() {
    for (int i = 0; i<4; i++) {
      colorpool.add(new_random_color());
    }
  }

  List<int> new_random_color() {
    List<int> l = new List<int>(3);
    l[0] = rng.nextInt(255);
    l[1] = rng.nextInt(255);
    l[2] = rng.nextInt(255);

    return l;
  }

  void process_entity(Entity e) {}

  void process_new_entity(Entity e) {
    // initialize color
    APISlot slot = e.get_component(APISlot);
    slot.color = colorpool[rng.nextInt(colorpool.length-1)];
  }
}

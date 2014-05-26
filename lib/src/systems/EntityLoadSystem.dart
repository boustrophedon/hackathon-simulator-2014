part of hacksim;

class EntityLoadSystem extends System {
  List<List<int>> colorpool;
  List<String> namepool;
  math.Random rng;

  int api_size = 40;
  int api_slot_size = 60;

  int api_spawn_index = 0;
  int slot_spawn_index = 0;

  Map<String, Function> spawn_map;

  EntityLoadSystem(World world) : super(world) {
    components_wanted = null;

    rng = new math.Random();
    colorpool = new List<List<int>>();

    namepool = new List<String>();

    spawn_map = new Map<String, Function>();
    spawn_map['api'] = spawn_api;
    spawn_map['api slot'] = spawn_api_slot;
  }

  void initialize() {
    init_colorpool(4);
    init_names();


    spawn_initial_api_slots();
    spawn_initial_apis();

    world.subscribe_event("SpawnEntity", handle_spawn);
  }

  void init_colorpool(int num_colors) {
    for (int i = 0; i<num_colors; i++) {
      colorpool.add(new_random_color());
    }
  }

  void init_names() {
    // these are just taken from hackru's sponsors. there is nothing special about them
    namepool.add("datto");
    namepool.add("bloomberg");
    namepool.add("digital ocean");
    namepool.add("twilio");
    namepool.add("sendgrid");
  }

  void handle_spawn(Map event) {
    Function spawn_function = spawn_map[event['kind']];
    if (spawn_function != null) {
      spawn_function();
    }
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

  String name_from_namepool() {
    return namepool[rng.nextInt(namepool.length-1)];
  }

  void spawn_initial_apis() {
    for (int i = 0; i<5; i++) {
      spawn_api();
    }
  }

  void spawn_api() {
    int spacing = 20; int offset = 10; int per_row = 5;
    int x = (api_spawn_index%per_row)*(api_size+spacing)+offset;
    int y = (api_spawn_index~/per_row)*(api_size+2*spacing)+offset;

    Entity e = world.new_entity();
    e.add_component(new Kind('api'));
    e.add_component(new Size(api_size, api_size));
    e.add_component(new Position(x,y));
    e.add_component(new Selection());
    e.add_component(new Draggable());
    e.add_component(new API(color_from_colorpool(), name_from_namepool()));
    e.add_to_world();

    api_spawn_index = (api_spawn_index+1)%15;
  }

  void spawn_initial_api_slots() {
    for (int i = 0; i<3; i++) {
      spawn_api_slot();
    }
  }

  void spawn_api_slot() {
    int spacing = 30; int offset = 30; int per_row = 3; int apis_offset = 250;
    int x = (slot_spawn_index%per_row)*(api_slot_size+spacing)+offset;
    int y = (slot_spawn_index~/per_row)*(api_slot_size+spacing)+offset+apis_offset;

    Entity e = world.new_entity();
    e.add_component(new Kind('api slot'));
    e.add_component(new Size(api_slot_size, api_slot_size));
    e.add_component(new Position(x,y));
    e.add_component(new Selection());
    e.add_component(new Draggable());
    e.add_component(new APISlot(color_from_colorpool()));
    e.add_to_world();

    slot_spawn_index = (slot_spawn_index+1)%9;
  }

  void process_entity(Entity entity) {}
  void remove_entity(Entity e) {}
}

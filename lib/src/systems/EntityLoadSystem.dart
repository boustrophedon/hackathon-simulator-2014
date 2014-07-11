part of hacksim;

class EntityLoadSystem extends System {
  List<List<int>> colorpool;
  List<String> namepool;
  List<ImageElement> recruiterpool;
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

    recruiterpool = new List<ImageElement>();

    spawn_map = new Map<String, Function>();
    spawn_map['api'] = spawn_api;
    spawn_map['api slot'] = spawn_api_slot;
    spawn_map['pivot label'] = spawn_pivot_label; // this is kind of dumb
    spawn_map['recruiter popup'] = spawn_recruiter_popup;
    // or rather, the uilabel stuff should be here too
  }

  void initialize() {
    init_colorpool(4);
    init_names();
    init_recruiters();

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
    namepool.add("mongodB"); // aeden
  }

  void init_recruiters() {
    var loader = world.globaldata['image_assets'];
    recruiterpool.add(loader.images['kaushal']);
    recruiterpool.add(loader.images['eddiez']);
  }

  void handle_spawn(Map event) {
    Function spawn_function = spawn_map[event['type']];
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
    return colorpool[rng.nextInt(colorpool.length)];
  }

  String name_from_namepool() {
    return namepool[rng.nextInt(namepool.length)];
  }

  ImageElement recruiter_from_pool() {
    return recruiterpool[rng.nextInt(recruiterpool.length)];
  }

  void spawn_initial_apis() {
    for (int i = 0; i<5; i++) {
      spawn_api();
    }
  }

  void spawn_api() {
    var loader = world.globaldata['image_assets'];

    int spacing = 20; int offset = 10; int per_row = 5;
    int x = (api_spawn_index%per_row)*(api_size+spacing)+offset;
    int y = (api_spawn_index~/per_row)*(api_size+2*spacing)+offset;

    Entity e = world.new_entity();
    e.add_component(new Kind('api'));
    e.add_component(new Size(api_size, api_size));
    e.add_component(new Position(x,y));
    e.add_component(new Selection());
    e.add_component(new Draggable());
    e.add_component(new API(color_from_colorpool(), name_from_namepool(), loader.images['russfrank']));
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

  void spawn_pivot_label() {
    Board board = world.globaldata['board'];
    int x = rng.nextInt(board.width);
    int y = rng.nextInt(board.height);

    Entity e = world.new_entity();
    e.add_component(new Kind('ui label'));
    e.add_component(new Position(x,y));
    e.add_component(new UI(font_size: 10, font_color: const [255,0,0]));
    e.add_component(new UILabel("PIVOT!1!!!!11!", null));
    e.add_component(new Animation(pivot_animation, null, const Duration(seconds: 2)));
    e.add_to_world();
  }

  String get_reply_text() {
    List<String> texts = ["Nope.", "Haha no.", "I apologize but I cannot.", "I am currently employed.", "Try again later.", "The magic conch told me not to.", "You're tacky and I hate you.", "Another company made a better offer.", "I am not familiar those technologies.", "Your company doesn't have enough traction.", "Hacker News said I shouldn't.", "Russ Frank said I shouldn't.", "Not enough ping pong tables in your offices.", "I am unwilling to relocate.", "I am still in high school.", "I am still in college.", "I am still in elementary school.", "Your office has a dog but I prefer cats.", "Your office has a cat but I prefer dogs.", "The timing of your offer is inopportune.", "I am doing social work in Tanzania starting next week.", "One of your engineers said they enjoyed Javascript."];
    return texts[rng.nextInt(texts.length)];
  }

  // this is a really ugly hack. i should do the teardown of b1 and b2 in the ui system
  // plus I wanted to do the popups overlapping and not going away until you press the right button
  // but the buttons all render on one layer so they stay on top of the new popups as well
  void do_popup_push(World world, Entity e, Entity b1, Entity b2, bool correct) {
    world.remove_entity(e);
    world.remove_entity(b1);
    world.remove_entity(b2);
    if (correct == true) {
      spawn_recruiter_popup();
    }
    else {
    }
  }

  void spawn_recruiter_popup() {
    int popup_width = 800;
    int popup_height = 900;

    Board board = world.globaldata['board'];
    int x = rng.nextInt(board.width-popup_width);
    int y = rng.nextInt(board.height-popup_height);

    String text = """Dear %%FIRSTNAME%%,

           We saw your hack at the last %%HACKATHON%% hackathon you attended and thought it was great. Our company is looking for ninja hacker pirates like you to lead the future in %%BUZZWORD1%% technology. If you or any developers you know are interested in working on the latest %%BUZZWORD2%% products, we'd love to have you. Send me an email and let me know what you think."""; // intentionally stupid looking. the template things are not meant to be filled in.

    Entity e = world.new_entity();
    e.add_component(new Kind('recruiter popup'));
    e.add_component(new Position(x,y));
    e.add_component(new Size(popup_width, popup_height));
    e.add_component(new Selection());
    e.add_component(new UI());
    e.add_component(new UIPopup(recruiter_from_pool(), text));
    e.add_to_world();

    // really I should have a spawn_button in this system rather than the ui but whatever
    // and all the spawn functions should take a Map passed in via the SpawnEntity event so that you can pass parameters
    bool correct = rng.nextBool();
    String reply_text1 = get_reply_text();
    Entity b1 = world.new_entity();
    Entity b2 = world.new_entity();

    int button_width = 700;
    int button_height = 50;

    b1.add_component(new Kind('popup button'));
    b1.add_component(new Position(x+(popup_width~/2)-(button_width~/2), y+(popup_height*0.75).toInt()));
    b1.add_component(new Size(button_width, button_height));
    b1.add_component(new Selection());
    b1.add_component(new UI());
    b1.add_component(new UIButton(reply_text1, ()=>(do_popup_push(world, e, b1, b2, correct))));
    b1.add_to_world();

    String reply_text2 = get_reply_text();
    while (reply_text1  == reply_text2) {
      reply_text2 = get_reply_text();
    }
    b2.add_component(new Kind('popup button'));
    b2.add_component(new Position(x+(popup_width~/2)-(button_width~/2), y+70+(popup_height*0.75).toInt()));
    b2.add_component(new Size(button_width, button_height));
    b2.add_component(new Selection());
    b2.add_component(new UI());
    b2.add_component(new UIButton(reply_text2, ()=>(do_popup_push(world, e, b1, b2, !correct))));
    b2.add_to_world();

    // need to add buttons at relevant positions
    // if this were a real gui system i guess they would be positioned relative to the parent (i.e. the popup) but who cares
  }


  void process_entity(Entity entity) {}
  void remove_entity(Entity e) {}
}

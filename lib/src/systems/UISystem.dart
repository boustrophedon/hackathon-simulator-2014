part of hacksim;

class UISystem extends System {
  
  int button_width = 200;
  int button_height = 100;

  UISystem(World world) : super(world) {
    components_wanted = null;

    world.subscribe_event("EntitySelected", handle_selection);
  }

  void initialize() {
    Board board = world.globaldata['board'];

    int x = board.ui_area.left + 50;
    int y = board.ui_area.top + 50;
    create_button(x,y, "Buy API Key", "BUY_API");
    create_button(x+button_width+(button_width~/2),y, "Buy API Slot", "BUY_SLOT");
  }

  void create_button(int x, int y, String text, String action) {
    Entity b = world.new_entity();
    b.add_component(new Kind('ui button'));
    b.add_component(new Size(button_width,button_height));
    b.add_component(new Position(x, y));
    b.add_component(new Selection());
    b.add_component(new UIButton(text, [0,0,0], [0,0,0], 22, action)); // hardcoded font size is bad
    b.add_to_world();
  }

  void handle_selection(Map event) {
    Entity e = event['entity'];
    Kind kind = e.get_component(Kind);
    if (kind.kind == 'ui button') {
      UIButton button = e.get_component(UIButton);
      world.send_event("ButtonPressed", {"action":button.action});
      world.globaldata['selected'] = null;
      // i don't really want to do this because i'd prefer each piece of globaldata
      // to be writable by only one system
      // oh well
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

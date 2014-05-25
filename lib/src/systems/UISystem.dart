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

    // XXX these are semi-hardcoded and bad. how2responsive design?
    int x = board.ui_area.left + 50;
    int y = board.ui_area.top + 50;
    create_button(x,y, "Buy API Key", "BUY_API");
    create_button(x+button_width+(button_width~/2),y, "Buy API Slot", "BUY_SLOT");

    x = board.ui_area.right - 300;
    y = board.ui_area.top + 50;
    create_label(x, y, "Money: {0}", ()=>([world.globaldata['money'].toString(),]));
  }

  void create_button(int x, int y, String text, String action) {
    Entity b = world.new_entity();
    b.add_component(new Kind('ui button'));
    b.add_component(new Size(button_width,button_height));
    b.add_component(new Position(x, y));
    b.add_component(new Selection());
    b.add_component(new UI()); // default render parameters in component definition
    b.add_component(new UIButton(text, action));
    b.add_to_world();
  }

  // update is a function that returns a list of items to be substituted into the text
  // in order
  void create_label(int x, int y, String text, Function update) {
    Entity l = world.new_entity();
    l.add_component(new Kind('ui label'));
    l.add_component(new Size(button_width, button_height)); // what should this even be? we can't really know ahead of time.
    // I guess for Size what we're going to have to do is render the text to a separate canvas and then use context.measureText
    // to update the size of the text inside UILabelRenderer? or inside UIRenderSystem
    l.add_component(new Position(x, y));
    l.add_component(new UI()); 
    l.add_component(new UILabel(text, update));
    l.add_to_world();
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

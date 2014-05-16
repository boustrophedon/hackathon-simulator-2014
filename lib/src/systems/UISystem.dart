part of hacksim;

class UISystem extends System {
  
  int button_width = 200;
  int button_height = 100;

  UISystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    Board board = world.globaldata['board'];

    int x = board.ui_area.left + 50;
    int y = board.ui_area.top + 50;
    create_button(x,y, "Buy API Key");
    create_button(x+button_width+(button_width/2),y, "Buy API Slot");
  }

  void create_button(int x, int y, String text) {
    Entity b = world.new_entity();
    b.add_component(new Kind('ui button'));
    b.add_component(new Size(button_width,button_height));
    b.add_component(new Position(x, y));
    b.add_component(new Selection());
    b.add_component(new UIButton(text, [255,255,255]));
    b.add_to_world();
  }

  void process_entity(Entity e) {}

}

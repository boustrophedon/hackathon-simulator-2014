part of hacksim;

class UISystem extends System {
  
  int button_width = 200;
  int button_height = 80;

  int bar_width = 500;
  int bar_height = 30;

  UISystem(World world) : super(world) {
    components_wanted = null;

    world.subscribe_event("EntitySelected", handle_selection);
  }

  void initialize() {
    Board board = world.globaldata['board'];

    // XXX these are semi-hardcoded and bad. how2responsive design?
    int x = board.ui_area.left + 30;
    int y = board.ui_area.top + 30;
    create_button(x, y, "Buy API Key", ()=>(world.send_event("BuyAPI", {})));
    x = x+button_width+(button_width~/8);
    create_button(x, y, "Buy API Slot", ()=>(world.send_event("BuyAPISlot", {})));

    x = x+button_width+(button_width~/8);
    create_button(x, y, "Submit Hack", ()=>(world.send_event("SubmitHack", {})));

    x = x+button_width+(button_width~/8);
    create_button(x, y, "Serve More Ads", ()=>(world.send_event("ServeNewAds", {})));

    x = board.ui_area.left + 30;
    y = board.ui_area.top + button_height + 60;
    create_button(x, y, "Get Caffeine", ()=>(world.send_event("GetCaffeine", {})));

    x = board.ui_area.right - 300;
    y = board.ui_area.top + 40;
    create_label(x, y, "Money: {0}", ()=>([world.globaldata['money'].toString(),]));

    x = board.ui_area.right - 300;
    y = board.ui_area.top + 80;
    create_label(x, y, "Hacker Cred: {0}", ()=>([world.globaldata['HackerCred'].toString(),]));

    x = board.ui_area.right - 300;
    y = board.ui_area.top + 120;
    create_label(x, y, "Ads served: {0}", ()=>([world.globaldata['AdsServed'].toString(),]));

    x = board.hack_area.left + 750;
    y = board.ui_area.top + 50;
    create_progressbar(x, y, [0,0,0], ()=>(world.globaldata['CaffeinePercentage']));

    x = board.hack_area.left + 750;
    y = board.ui_area.top + 100;
    create_progressbar(x, y, [0,0,0], ()=>(world.globaldata['PercentageCompleted']));
    
    y = board.ui_area.top + 40;
    create_label(x, y, "Caffeine: {0}mg", ()=>([world.globaldata['CaffeineLevel'].round().toString(),]));

    y = board.ui_area.top + 160;
    create_label(x, y, "Hack progress: {0}%", ()=>([(world.globaldata['PercentageCompleted']*100).round().toString(),]));

    y = board.ui_area.top + 185;
    create_label(x, y, "Hackathons attended: {0}", ()=>([world.globaldata['HackathonsAttended'].toString(),]));
  }

  void create_button(int x, int y, String text, Function action) {
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

  // update is a function that returns the new percentage the progress bar should be filled to
  void create_progressbar(int x, int y, List<int> color, Function update) {
    Entity b = world.new_entity();
    b.add_component(new Kind('ui progressbar'));
    b.add_component(new Position(x,y));
    b.add_component(new Size(bar_width, bar_height));
    b.add_component(new UI(fill_color: color));
    b.add_component(new UIProgressBar(update));
    b.add_to_world();
  }

  void handle_selection(Map event) {
    Entity e = event['entity'];
    Kind kind = e.get_component(Kind);
    if (kind.kind == 'ui button') {
      UIButton button = e.get_component(UIButton);
      button.action();
      world.globaldata['selected'] = null;
      // i don't really want to do this because i'd prefer each piece of globaldata
      // to be writable by only one system
      // oh well
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

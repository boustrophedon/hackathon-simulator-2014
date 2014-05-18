part of hacksim;

class PickingSystem extends RenderSystem {
  Map<int, Entity> id_map;

  int cur_id = 10;
  int max_id = 0xFFFFFF;

  PickingSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,Selection]);

    id_map = new Map<int, Entity>();

    world.subscribe_event('MouseDown', handle_click);
    world.subscribe_event('TouchStart', handle_click);
    world.subscribe_event('TouchEnd', handle_touchend); // kind of a hack
  }

  void initialize() {
    CanvasElement g_can = world.globaldata['canvas'];

    CanvasElement p_canvas = new CanvasElement(width: g_can.width, height: g_can.height);
    p_canvas.id = "picking";

    set_context(p_canvas);

    renderers['ui button'] = new RectPickingRenderer(canvas, context);
    renderers['api slot'] = new RectPickingRenderer(canvas, context);
    renderers['api'] = new RectPickingRenderer(canvas, context);
  }

  void handle_click(Map event) {
    int x = event['x']; int y = event['y'];
    render_picking_canvas(); // in the future maybe could only render part of the screen

    pick_from_canvas(x,y);

  }

  void handle_touchend(Map event) {
    if (world.globaldata['selected'] != null) {
      deselect_current();
    }
  }

  void select_current(Entity e, int x, int y) {
    world.globaldata['selected'] = e;
    // x and y are screen coords, probably not necessary here but might be for, eg, ground selection -> world coords in a moba or something
    world.send_event('EntitySelected', {'entity':e, 'x':x, 'y':y});
  }

  void deselect_current() {
    world.send_event('EntityDeselected', {'entity':world.globaldata['selected']});
    world.globaldata['selected'] = null;
  }

  void pick_from_canvas(int x, int y) {
    ImageData data = context.getImageData(x,y,1,1);
    var arr = data.data;
    num id = arr[0]*65536 + arr[1]*256 + arr[2];
    Entity e = id_map[id];

    if (world.globaldata['selected'] != null) {
      deselect_current();
    }
    else {
      if (e != null) {
        select_current(e, x, y);
      }
    }
  }

  void render_picking_canvas() {
    // i guess i could just call super.process() here but that is a bit opaque
    context.clearRect(0,0,screen_width,screen_height);
    render_entities();
  }

  void process_new_entity(Entity e) {
    Selection pick = e.get_component(Selection);
    if (pick.id == null) {
      pick.id = cur_id;

      id_map[cur_id] = e;

      cur_id+=10;
      // this is dumb but whatever
      if (cur_id > max_id) {
        cur_id = 5;
      }
    }

    super.process_new_entity(e);

  }

  void remove_entity(Entity e) {
    if (e.has_component(Selection)) {
      id_map.remove(e.get_component(Selection).id);
      super.remove_entity(e);
    }
  }

  void process_entity(Entity e) {}

}

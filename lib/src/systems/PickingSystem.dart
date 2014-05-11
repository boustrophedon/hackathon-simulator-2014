part of hacksim;

class PickingSystem extends System {
  CanvasElement p_canvas;
  CanvasRenderingContext2D p_context;

  PickingRenderer picking_renderer;

  int width;
  int height;

  Map<int, Entity> id_map;

  int cur_id = 10;
  int max_id = 0xFFFFFF;

  PickingSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,Selection]);

    id_map = new Map<int, Entity>();

    world.subscribe_event('MouseDown', handle_click);
    world.subscribe_event('TouchStart', handle_click);
  }

  void initialize() {
    CanvasElement g_can = world.globaldata['canvas'];
    width = g_can.width;
    height = g_can.height;

    p_canvas = new CanvasElement(width: width, height: height);
    p_canvas.id = "picking";
    p_context = p_canvas.context2D;

    picking_renderer = new PickingRenderer(p_canvas, p_context);
  }

  void handle_click(Map event) {
    int x = event['x']; int y = event['y'];
    
    render_picking_canvas(); // in the future maybe could only render part of the screen

    pick_from_canvas(x,y);

  }

  void pick_from_canvas(int x, int y) {
    ImageData data = p_context.getImageData(x,y,1,1);
    var arr = data.data;
    num id = arr[0]*65536 + arr[1]*256 + arr[2];
    Entity e = id_map[id];
    if (e!=null) {
      if (world.globaldata['selected'] == e) {
        world.globaldata['selected'] = null;
        world.send_event('EntityDeselected', {'entity':e, 'x':x, 'y':y});
      }
      else {
        world.globaldata['selected'] = e;
        // x and y are screen coords, probably not necessary here but might be for, eg, ground selection -> world coords in a moba or something
        world.send_event('EntitySelected', {'entity':e, 'x':x, 'y':y});
      }
    }
  }

  void render_picking_canvas() {
    p_context.clearRect(0,0,width,height);

    for (Entity e in entities) {
      picking_renderer.render_entity(e);
    }
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
  }

  void process_entity(Entity e) {}

}

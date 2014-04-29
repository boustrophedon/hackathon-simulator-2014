part of hacksim;

class PickingSystem extends System {
  CanvasElement p_canvas;
  CanvasRenderingContext2D p_context;

  int width;
  int height;

  Map<int, Entity> id_map;

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
    p_context.fillStyle = '#000000';
    p_context.clearRect(0,0,width,height);
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
      world.globaldata['selected'] = e;
      // x and y probably not necessary
      world.send_event('EntitySelected', {'entity':e, 'x':x, 'y':y});
    }
  }

  void render_picking_canvas() {
    p_context.clearRect(0,0,width,height);

    int i = 230;
    for (Entity e in entities) {
      Position pos = e.get_component(Position);
      
      id_map[i] = e;

      p_context.save();
      p_context.fillStyle = '#'+i.toRadixString(16).padLeft(6, '0');
      p_context.fillRect(pos.x, pos.y, 40, 40); // 40 is magic. need to make a size or rendering component or something.
      p_context.restore();

      i+=10;
    }
  }

  void process_entity(Entity e) {}
}

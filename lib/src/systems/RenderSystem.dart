part of hacksim;

class RenderSystem extends System {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int screen_width;
  int screen_height;

  RenderSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);
  }

  void initialize() {
    canvas = world.globaldata['canvas'];

    // make the canvas the full size of the window
    canvas.height = window.innerHeight;
    canvas.width = window.innerWidth;

    context = canvas.context2D;
    screen_width = canvas.width;
    screen_height = canvas.height;
  }

  void process() {
    context.clearRect(0, 0, screen_width, screen_height);
    for (Entity e in entities) {
      process_entity(e);
    }
  }

  void process_entity(Entity entity) {
    var pos = entity.get_component(Position); // need to define [] operator
    draw_rect_at(pos.x, pos.y);
  }

  //XXX i'd like to replace this with a, like, parametrizable XRenderer class, like RectRenderer and APIRenderer
  // which i can then reuse in the picking thing by changing the parameters (which come from a component)
  void draw_rect_at(int x, int y) {
    context.save();
    context.fillStyle = 'rgb(0, 50, 200)';
    context.fillRect(x, y, 40, 40);
    context.restore();
  }
}


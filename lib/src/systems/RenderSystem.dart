part of hacksim;

class RenderSystem extends System {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int screen_width;
  int screen_height;
  
  PuzzleRenderer puzzle_renderer;

  RenderSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,Size]);
  }

  void initialize() {
    canvas = world.globaldata['canvas'];

    // make the canvas the full size of the window
    canvas.height = window.innerHeight;
    canvas.width = window.innerWidth;

    context = canvas.context2D;
    screen_width = canvas.width;
    screen_height = canvas.height;

    puzzle_renderer = new PuzzleRenderer(canvas, context);
  }

  void process() {
    context.clearRect(0, 0, screen_width, screen_height);
    for (Entity e in entities) {
      process_entity(e);
    }
  }

  void process_entity(Entity entity) {
    if (entity.has_component(Puzzle)) {
      puzzle_renderer.render_entity(entity);
    }
  }
}


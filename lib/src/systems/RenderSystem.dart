part of hacksim;

class RenderSystem extends System {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int screen_width;
  int screen_height;
  
  LinkedHashMap<String, Renderer> renderers;

  APIRenderer api_renderer;
  APISlotRenderer slot_renderer;

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

    // order of renderers specified here specifies draw order. first in first out -> last thing added gets drawn on top
    renderers = new Map<String, Renderer>();
    renderers['api slot'] = new APISlotRenderer(canvas, context);
    renderers['api'] = new APIRenderer(canvas, context);
  }

  void process() {
    context.clearRect(0, 0, screen_width, screen_height);
    for (Renderer r in renderers.values) {
      r.render_entities();
    }
  }
  void process_entity(Entity e) {}

  void process_new_entity(Entity entity) {
    Kind kind = entity.get_component(Kind);
    if (renderers.containsKey(kind.kind)) {
      renderers[kind.kind].add_entity(entity);
    }
  }
}


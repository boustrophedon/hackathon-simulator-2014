part of hacksim;

class RenderSystem extends System {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int screen_width;
  int screen_height;
  
  LinkedHashMap<String, Renderer> renderers;

  RenderSystem(World world) : super(world) {
    renderers = new Map<String, Renderer>();
    components_wanted = new Set.from([Position,Size]);
  }

  void set_context(CanvasElement canv) {
    this.canvas = canv;

    context = canvas.context2D;
    screen_width = canvas.width;
    screen_height = canvas.height;
  }

  void initialize() {
    set_context(world.globaldata['canvas']);

    // order of renderers specified here specifies draw order. first in first out -> last thing added gets drawn on top
    renderers['board'] = new BoardRenderer(canvas, context, world.globaldata['board']);
    renderers['api slot'] = new APISlotRenderer(canvas, context);
    renderers['api'] = new APIRenderer(canvas, context);
  }

  void process() {
    context.clearRect(0, 0, screen_width, screen_height);
    render_entities();
  }

  void render_entities() {
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

  void remove_entity(Entity entity) {
    Kind kind = entity.get_component(Kind);
    if (renderers.containsKey(kind.kind)) {
      renderers[kind.kind].remove_entity(entity);
    }
  }
}


part of hacksim;

class RenderSystem extends System {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int screen_width;
  int screen_height;
  int display_width;
  int display_height;

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

    display_height = window.innerHeight;
    display_width = ((screen_width/screen_height)*display_height).toInt();


    canvas.style.height = display_height.toString() + "px";
    canvas.style.width = display_width.toString() + "px";

  }

  void initialize() {
    set_context(world.globaldata['canvas']);
    world.globaldata['display_height'] = display_height;
    world.globaldata['display_width'] = display_width;

    // order of renderers specified here specifies draw order. first in first out -> last thing added gets drawn on top
    renderers['api slot'] = new APISlotRenderer(canvas, context);
    renderers['api'] = new APIRenderer(canvas, context);
  }

  void process() {
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


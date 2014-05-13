part of hacksim;

class RenderSystem extends System {

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  int screen_width;
  int screen_height;
  
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

    api_renderer = new APIRenderer(canvas, context);
    slot_renderer = new APISlotRenderer(canvas, context);
  }

  void process() {
    context.clearRect(0, 0, screen_width, screen_height);
    for (Entity e in entities) {
      process_entity(e);
    }
  }

  void process_entity(Entity entity) {
    // this needs to be optimized to add entities to renderers and then just call render on the renderer
    // rather than selecting the entities per frame
    //
    // the renderers themselves need to set up the rendering contexts and then not do .save/.restore
    //
    // also should do something about manually ordering them here
    if (entity.has_component(APISlot)) {
      slot_renderer.render_entity(entity);
    }
    else if (entity.has_component(API)) {
      api_renderer.render_entity(entity);
    }
  }
}


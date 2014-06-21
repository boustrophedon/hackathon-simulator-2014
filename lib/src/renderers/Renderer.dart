part of hacksim;

class Renderer {
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  Set<Entity> entities;

  num sx,sy;

  Renderer(CanvasElement canv, CanvasRenderingContext2D ctx) {
    canvas = canv;
    context = ctx;
    sx = canvas.width/1920;
    sy = canvas.height/1080;
    entities = new Set<Entity>();
  }

  // not necessary for me now but would be nice to have in the future
  // and super easy to implement here and now while i'm at it.
  void setup() {
    context.save();
    context.scale(sx,sy);
  }
  void teardown() {
    context.restore();
  }

  void render_entities() {
    setup();
    for (Entity e in entities) {
      render_entity(e);
    }
    teardown();
  }

  void add_entity(Entity e) {
    entities.add(e);
  }

  void remove_entity(Entity e) {
    entities.remove(e);
  }

  void render_entity(Entity e) {}
}

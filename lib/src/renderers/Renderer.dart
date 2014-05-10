part of hacksim;

class Renderer {
  CanvasElement canvas;
  CanvasRenderingContext2D context;

  Renderer(this.canvas, this.context);

  void render_entity(Entity e) {}
}

part of hacksim;

class APIRenderer extends Renderer {
  APIRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);

    context.save();
    context.fillStyle = 'rgb(0, 50, 200)';
    context.fillRect(pos.x, pos.y, size.width, size.height);
    context.restore();
  }
} 

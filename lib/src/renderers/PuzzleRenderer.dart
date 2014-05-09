part of hacksim;

class PuzzleRenderer extends Renderer {
  PuzzleRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void renderEntity(Entity e) {
    Position pos = e.get_component(Position);
    context.save();
    context.fillStyle = 'rgb(0, 50, 200)';
    context.fillRect(pos.x, pos.y, 40, 40);
    context.restore();
  }
} 

part of hacksim;

class RectPickingRenderer extends Renderer {
  RectPickingRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx) {
    context.fillStyle = '#000000';
    context.clearRect(0,0,canvas.width,canvas.height); 
  }

  void render_entity(Entity e) {
    Selection sel = e.get_component(Selection);
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);

    context.fillStyle = '#'+(sel.id).toRadixString(16).padLeft(6, '0');
    context.fillRect(pos.x, pos.y, size.width, size.height);
  }
}

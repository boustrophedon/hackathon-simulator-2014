part of hacksim;

class PickingRenderer extends Renderer {
  PickingRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx) {
    context.fillStyle = '#000000';
    context.clearRect(0,0,canvas.width,canvas.height); 
  }

  void render_entity(Entity e) {
    Selection sel = e.get_component(Selection);
    Position pos = e.get_component(Position);

    context.save();
    context.fillStyle = '#'+(sel.id).toRadixString(16).padLeft(6, '0');
    context.fillRect(pos.x, pos.y, 40, 40); // 40 is magic. need to make a size or rendering component or something.
    context.restore();

  }
}

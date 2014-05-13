part of hacksim;

class APISlotRenderer extends Renderer {
  APISlotRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    APISlot slot = e.get_component(APISlot);

    context.save();
    context.fillStyle = 'rgb(${slot.color[0]}, ${slot.color[1]}, ${slot.color[2]})';
    context.fillRect(pos.x, pos.y, size.width, size.height);

    context.fillStyle = 'rgb(0,0,0)';
    context.fillRect(pos.x+10, pos.y+10, size.width-20, size.height-20);

    context.restore();
  }
} 

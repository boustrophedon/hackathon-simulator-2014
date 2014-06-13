part of hacksim;

class APISlotRenderer extends Renderer {
  APISlotRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    APISlot slot = e.get_component(APISlot);

    context.strokeStyle = 'rgba(${slot.color_string})';
    context.lineWidth = 10;
    context.strokeRect(pos.x+5, pos.y+5, size.width-10, size.height-10);

  }
} 

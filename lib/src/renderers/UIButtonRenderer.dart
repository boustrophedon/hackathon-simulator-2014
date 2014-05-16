part of hacksim;

void draw_rounded_rect(CanvasRenderingContext2D context, int x, int y, int w, int h, int radius) {
  // stolen from http://stackoverflow.com/a/7838871
  context.beginPath();
  context.moveTo(x+radius, y);
  context.arcTo(x+w, y,   x+w, y+h, radius);
  context.arcTo(x+w, y+h, x,   y+h, radius);
  context.arcTo(x,   y+h, x,   y,   radius);
  context.arcTo(x,   y,   x+w, y,   radius);
  context.closePath();
}

class UIButtonRenderer extends Renderer {
  UIButtonRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    UIButton button = e.get_component(UIButton);

    context.fillStyle = 'rgb(${button.color_string})';
    context.strokeStyle = 'rgb(0,0,0)';

    draw_rounded_rect(context, pos.x, pos.y, size.width, size.height, 20); // radius of 20 is arbitrary for now
    context.stroke();
  }
} 

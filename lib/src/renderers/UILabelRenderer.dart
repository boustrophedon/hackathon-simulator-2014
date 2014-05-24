part of hacksim;

class UILabelRenderer extends Renderer {
  UILabelRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    UILabel label = e.get_component(UILabel);
  
    context.fillStyle = 'rgb(${label.font_color_string})';
    context.font = label.font;
    context.fillText(label.rendered_text, pos.x, pos.y);
  }

}

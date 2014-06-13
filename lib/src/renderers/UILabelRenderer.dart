part of hacksim;

class UILabelRenderer extends Renderer {
  UILabelRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    UILabel label = e.get_component(UILabel);
    UI ui = e.get_component(UI);
  
    context.fillStyle = 'rgba(${ui.font_color_string})';
    context.font = ui.font;
    context.fillText(label.rendered_text, pos.x, pos.y);
  }

}

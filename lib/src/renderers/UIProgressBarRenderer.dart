part of hacksim;

class UIProgressBarRenderer extends Renderer {
  UIProgressBarRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    UI ui = e.get_component(UI);
    UIProgressBar bar = e.get_component(UIProgressBar);

    context.strokeStyle = 'rgba(${ui.border_color_string})';
    context.strokeRect(pos.x, pos.y, size.width, size.height);

    context.fillStyle = 'rgba(${ui.fill_color_string})';
    context.fillRect(pos.x, pos.y, (size.width*bar.progress), size.height);
  }
}

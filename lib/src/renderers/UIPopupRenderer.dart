part of hacksim;

List<String> break_into_lines(String text, int maxwidth) {
  return null;
}

class UIPopupRenderer extends Renderer {
  UIPopupRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    UI ui = e.get_component(UI);
    UIPopup pop = e.get_component(UIPopup);

    context.strokeStyle = 'rgba(${ui.border_color_string})';

    draw_rounded_rect(context, pos.x, pos.y, size.width, size.height, 10);
    context.stroke();

    int lnum = 0;
    for (String line in break_into_lines(pop.text, (size.width*3)~/4)) {
        context.fillStyle = 'rgba(${ui.font_color_string})';
        context.font = "${ui.font_size}pt ${ui.type_face}";
        int xoffset = (context.measureText("${line}").width)~/2;
        int yoffset = 50 + lnum*(ui.font_size);
        context.fillText(line, pos.x+(size.width~/2)-xoffset, pos.y+yoffset+(ui.font_size~/4));

        lnum++;
    }
  }
}

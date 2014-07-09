part of hacksim;


List<int> indices_of_spaces(String text) {
  var spaces = new List<int>();
  
  int i = 0;
  for (String c in text.split('')) {
    if (c == " ") {
      spaces.add(i);
    }
    i++;
  }
  return spaces;
}

class UIPopupRenderer extends Renderer {
  UIPopupRenderer(CanvasElement canv, CanvasRenderingContext2D ctx) : super(canv, ctx);

  List<String> break_into_lines(String text, int maxwidth) {
    var lines = new List<String>();

    String test_line = null;
    int last_line = 0; int prev_space = 0;
    for (int space in indices_of_spaces(text)) {
      test_line = text.substring(last_line, space);
      if (context.measureText(test_line).width > maxwidth) {
        lines.add(text.substring(last_line, prev_space));
        last_line = prev_space;
      }
      else if (test_line.contains("\n")) {
        lines.add(text.substring(last_line, prev_space));
        last_line = prev_space;
      }
      prev_space = space;
    }
    lines.add(text.substring(last_line));
    return lines;
  }

  void add_entity(Entity e) {
    var pop = e.get_component(UIPopup);
    var size = e.get_component(Size);
    pop.lines = break_into_lines(pop.text, (size.width)~/3);

    entities.add(e);
  }

  void render_entity(Entity e) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    UI ui = e.get_component(UI);
    UIPopup pop = e.get_component(UIPopup);

    context.strokeStyle = 'rgba(${ui.border_color_string})';
    context.fillStyle = 'rgba(${ui.fill_color_string})';

    draw_rounded_rect(context, pos.x, pos.y, size.width, size.height, 10);
    context.fill();
    context.stroke();

    int lnum = 0;
    for (String line in pop.lines) {
        context.fillStyle = 'rgba(${ui.font_color_string})';
        context.font = "${ui.font_size}pt ${ui.type_face}";
        int xoffset = (context.measureText("${line}").width)~/2;
        int yoffset = (50 + lnum*1.5*(ui.font_size)).toInt();
        context.fillText(line, pos.x+(size.width~/2)-xoffset, pos.y+yoffset+(ui.font_size~/4));

        lnum++;
    }
  }
}

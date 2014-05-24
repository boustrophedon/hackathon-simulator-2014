part of hacksim;

class Position implements Component {
  int x;
  int y;
  Position(this.x, this.y);
}

class Size implements Component {
  int width;
  int height;
  Size(this.width, this.height);
}

class Kind implements Component {
  String kind;
  Kind(this.kind);
}

class Selection implements Component { 
  int id;
  Selection();
}

class Draggable implements Component {
  Draggable();
}

class API implements Component {
  // need some sort of shape data here
  // and orientation I guess
  // and api name
  List<int> color;
  String color_string;
  Entity current_apislot = null;
  API(List<int> col) {
    color = col;
    color_string = "${color[0]}, ${color[1]}, ${color[2]}";
  }
}

class APISlot implements Component {
  Entity api_inside = null;
  List<int> color;
  String color_string;
  APISlot(List<int> col) {
    color = col;
    color_string = "${color[0]}, ${color[1]}, ${color[2]}";
  }
}

class UI implements Component {
  UI();
}

class UIButton implements Component {
  String text;
  List<int> font_color;
  List<int> border_color;
  String font_color_string;
  String border_color_string;
  String font;
  String action;
  UIButton(String text, List<int> font_color, List<int> border_color, int font_size, String action) {
    this.text = text;
 
    this.font_color = font_color;
    this.font_color_string = "${font_color[0]}, ${font_color[1]}, ${font_color[2]}";

    this.border_color = border_color;
    this.border_color_string = "${border_color[0]}, ${border_color[1]}, ${border_color[2]}";

    this.font = "${font_size}pt Comic Sans"; //lel

    this.action = action; // I don't really like action going with all the style stuff, but I don't really want to give it its own component either
  }
}

// should probably combine a lot of the stuff below and above and move it into the UI component

class UILabel implements Component {
  String text;
  String rendered_text;
  Function update;
  List<int> font_color;
  String font_color_string;
  String font;
  UILabel(String text, Function update, List<int> font_color, int font_size) {
    this.text = text;
    this.rendered_text = text;
    this.font_color = font_color;
    this.font_color_string = "${font_color[0]}, ${font_color[1]}, ${font_color[2]}";

    this.font = "${font_size}pt Comic Sans";

    this.update = update;
  }
}

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
  String name;

  String color_string;
  Entity current_apislot = null;
  API(List<int> color, String name) {
    this.color = color;
    this.name = name;
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
  List<int> font_color;
  List<int> border_color;
  List<int> fill_color;
  String font_color_string;
  String border_color_string;
  String fill_color_string;
  String font;
  String type_face;
  int font_size;
  UI({List<int> font_color: null, List<int> border_color: null, List<int> fill_color: null,
     String type_face: "Comic Sans", int font_size: 22}) {
    if (font_color == null) { font_color = [0,0,0]; }
    this.font_color = font_color;
    this.font_color_string = "${font_color[0]}, ${font_color[1]}, ${font_color[2]}";

    if (border_color == null) { border_color = [0,0,0]; }
    this.border_color = border_color;
    this.border_color_string = "${border_color[0]}, ${border_color[1]}, ${border_color[2]}";

    if (fill_color == null) { fill_color = [255,255,255]; }
    this.fill_color = fill_color;
    this.fill_color_string = "${fill_color[0]}, ${fill_color[1]}, ${fill_color[2]}";

    this.font_size = font_size;
    this.type_face = type_face;
    this.font = "${font_size}pt $type_face";
  }
}

class UIButton implements Component {
  String text;
  String action;
  UIButton(String text, String action) {
    this.text = text;
    this.action = action;
  }
}

// probably should typedef the update functions here. label_update and progress_update

class UILabel implements Component {
  String text;
  String rendered_text;
  Function update;
  UILabel(String text, Function update) {
    this.text = text;
    this.rendered_text = text;
    this.update = update;
  }
}

class UIProgressBar implements Component {
  Function update;
  num progress;
  UIProgressBar(Function update) {
    this.update = update;
    num progress;
  }
}

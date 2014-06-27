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
  List<int> color;
  String name;
  
  ImageElement img;

  String color_string;
  Entity current_apislot = null;
  API(List<int> color, String name, ImageElement img) {
    this.color = color;
    this.name = name;
    this.img = img;
    color_string = "${color[0]}, ${color[1]}, ${color[2]}, 1";
  }
}

class APISlot implements Component {
  Entity api_inside = null;
  List<int> color;
  String color_string;
  APISlot(List<int> col) {
    color = col;
    color_string = "${color[0]}, ${color[1]}, ${color[2]}, 1";
  }
}

class UI implements Component {
  List<int> font_color;
  List<int> border_color;
  List<int> fill_color;
  String font_color_string;
  String border_color_string;
  String fill_color_string;
  String type_face;
  int font_size;
  UI({List<int> font_color: null, List<int> border_color: null, List<int> fill_color: null,
     String type_face: "Comic Sans", int font_size: 18}) {
    if (font_color == null) { font_color = const [0,0,0]; }
    this.font_color = font_color;
    this.font_color_string = "${font_color[0]}, ${font_color[1]}, ${font_color[2]}, 1";

    if (border_color == null) { border_color = const [0,0,0]; }
    this.border_color = border_color;
    this.border_color_string = "${border_color[0]}, ${border_color[1]}, ${border_color[2]}, 1";

    if (fill_color == null) { fill_color = const [255,255,255]; }
    this.fill_color = fill_color;
    this.fill_color_string = "${fill_color[0]}, ${fill_color[1]}, ${fill_color[2]}, 1";

    this.type_face = type_face;
    this.font_size = font_size;
  }
}

class UIButton implements Component {
  String text;
  Function action;
  UIButton(this.text, this.action);
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
  num progress = 0;
  UIProgressBar(this.update);
}

class Animation implements Component {
  Function update;
  Function complete;
  Duration duration;
  num progress = 0;
  Animation(this.update, this.complete, this.duration);
}

class Board implements Component {
  int width;
  int height;

  Rectangle purchase_area;
  Rectangle ui_area;
  Rectangle hack_area;
  Rectangle board_area;

  VideoElement background;

  Board(CanvasElement canvas, VideoElement bg_video) {
    width = canvas.width;
    height = canvas.height;

    int purchase_top = 0;
    int purchase_left = 0;
    int purchase_right = (width*0.16).toInt();
    int purchase_bottom = (height*0.75).toInt();

    int ui_top = purchase_bottom;
    int ui_left = 0;
    int ui_right = width;
    int ui_bottom = height;

    int hack_top = 0;
    int hack_left = purchase_right;
    int hack_right = width;
    int hack_bottom = ui_top;

    purchase_area = new Rectangle.fromPoints(new Point(purchase_left, purchase_top), new Point(purchase_right, purchase_bottom));
    ui_area = new Rectangle.fromPoints(new Point(ui_left, ui_top), new Point(ui_right, ui_bottom));
    hack_area = new Rectangle.fromPoints(new Point(hack_left, hack_top), new Point(hack_right, hack_bottom));

    board_area = canvas.getBoundingClientRect(); // #getrekt

    background = bg_video;
    background.autoplay = true;
    background.loop = true;
    background.play();
  }
}


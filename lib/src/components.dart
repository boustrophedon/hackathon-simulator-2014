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

class UIButton implements Component {
  String text;
  List<int> color;
  String color_string;
  UIButton(String txt, List<int> col) {
    text = txt;
    color = col;
    color_string = "${color[0]}, ${color[1]}, ${color[2]}";
  }
}

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
  API() {
    color = new List<int>(3);
  }
}

class APISlot implements Component {
  Entity api_inside = null;
  List<int> color; // apis can only go inside ones with matching colors
  APISlot() {
    color = new List<int>(3);
  }
}

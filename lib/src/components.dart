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

class Puzzle implements Component {
  // need some sort of shape data here
  // and orientation I guess
  // and api name
  Puzzle();
}

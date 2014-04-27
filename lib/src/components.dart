part of hacksim;

class Position implements Component {
  int x;
  int y;
  Position(this.x, this.y);
}

class Kind implements Component {
  String kind;
  Kind(this.kind);
}

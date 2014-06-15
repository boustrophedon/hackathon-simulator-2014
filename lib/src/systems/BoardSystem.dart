part of hacksim;

class Board {
  Rectangle purchase_area;
  Rectangle ui_area;
  Rectangle hack_area;

  VideoElement background;

  CanvasElement vcanvas;
  CanvasRenderingContext2D vcontext;

  Board(CanvasElement canvas, VideoElement bg_video) {
    int width = canvas.width;
    int height = canvas.height;

    int purchase_top = 0;
    int purchase_left = 0;
    int purchase_right = (width*0.16).toInt();
    int purchase_bottom = (height*0.8).toInt();

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

    background = bg_video;
    background.width = hack_area.width;
    background.height = hack_area.height;
    background.autoplay = true;
    background.loop = true;
    background.play();

    vcanvas = new CanvasElement(width: (hack_area.width), height:(hack_area.height);
    vcontext = vcanvas.context2D;
  }
}

class BoardSystem extends System {

  Board board;

  BoardSystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    var loader = world.globaldata['video_assets'];
    board = new Board(world.globaldata['canvas'], loader.videos['hackru']);
    world.globaldata['board'] = board;
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

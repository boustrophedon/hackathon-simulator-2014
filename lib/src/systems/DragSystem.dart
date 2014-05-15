part of hacksim;

class DragSystem extends System {
  Entity current = null;
  int xoffset;
  int yoffset;

  // I'm not really sure if this should be here but I don't really want to put it in the slot system
  // and I don't think it's worth having its own system
  List<Entity> slots;

  DragSystem(World world) : super(world) {
    components_wanted = new Set.from([Position, Draggable]);

    world.subscribe_event('EntitySelected', handle_select);
    world.subscribe_event('EntityDeselected', handle_deselect);
    world.subscribe_event('MouseMove', handle_move);
    world.subscribe_event('TouchMove', handle_move);
  }

  void initialize() {
    slots = new List<Entity>();
  }

  void process_entity(Entity e) {}

  void process_new_entity(Entity e) {
    Kind kind = e.get_component(Kind);
    if (kind.kind == "api slot") {
      slots.add(e);
    }
  }

  void handle_select(Map event) {
    Entity e = event['entity'];
    if (e.has_component(Draggable)) {
      Kind kind = e.get_component(Kind);
      if (kind.kind == 'api') {
        pickup_api(event, e);
      }
      else if (kind.kind == 'api slot') {
        pickup_apislot(event, e);
      }
    }
  }

  void set_offsets(int x, int y, Position pos) {
    xoffset = x - pos.x;
    yoffset = y - pos.y;
  }

  void pickup_api(Map event, Entity api) {
    current = api;
    set_offsets(event['x'],event['y'], current.get_component(Position));

    API api_c = api.get_component(API);
    if (api_c.current_apislot != null) {
      APISlot slot = api_c.current_apislot.get_component(APISlot);
      slot.api_inside = null;
    }
  }
  void pickup_apislot(Map event, Entity apislot) {
    APISlot slot = apislot.get_component(APISlot);
    if (slot.api_inside != null) {
      current = slot.api_inside;
      slot.api_inside = null;
      set_offsets(event['x'],event['y'], current.get_component(Position));
    }
    else {
      current = apislot;
      set_offsets(event['x'],event['y'], current.get_component(Position));
    }
  }

  void handle_deselect(Map event) {
    Entity e = event['entity'];
    if (e.has_component(Draggable)) {
      Kind kind = e.get_component(Kind);
      if (kind.kind == "api") {
        drop_api(event, e);
      }
      else if (kind.kind == "api slot") {
        drop_apislot(event, e);
      }
    }
  }

  void drop_api(Map event, Entity api) {
    Entity nearest = get_nearest_slot(api);
    if (nearest != null) {
      APISlot slot = nearest.get_component(APISlot);

      if (slot.api_inside == null) { // if there's not already an api inside
        API api_c = api.get_component(API);
        Position slotpos = nearest.get_component(Position);
        Position apipos = api.get_component(Position);

        apipos.x = slotpos.x+10;
        apipos.y = slotpos.y+10;
        slot.api_inside = api;
        api_c.current_apislot = nearest;
      }
    }
    current = null;  
  }

  void drop_apislot(Map event, Entity apislot) {
    current = null;
  }

  Entity get_nearest_slot(Entity e) {
    Entity nearest = null;
    num smallest = 60; // only take slots close enough to begin with
    for (Entity sl in slots) {
      num d = distance(sl, e);
      if (d < smallest) {
        nearest = sl;
        smallest = d;
      }
    }
    return nearest;
  }

  void handle_move(Map event) {
    if (current != null) {
      Kind kind = current.get_component(Kind);
      if (kind.kind == "api") {
        move_api(current, event['x'], event['y']);
      }
      else if (kind.kind == "api slot") {
        move_api_slot(current, event['x'], event['y']);
      }
    }
  }

  // these are separate because initially i wanted apis to snap into api slots as they were moving
  void move_api(Entity e, int x, int y) {
    if (check_bounds(e, x, y)) {
      return;
    }
    Position pos = e.get_component(Position);
    pos.x = x - xoffset;
    pos.y = y - yoffset;
  }
  
  void move_api_slot(Entity e, int x, int y) {
    if (check_bounds(e, x, y)) {
      return;
    }
    Position pos = e.get_component(Position);
    pos.x = x - xoffset;
    pos.y = y - yoffset;
  }

  bool check_bounds(Entity e, int x, int y) {
    Position pos = e.get_component(Position);
    Size size = e.get_component(Size);
    Board board = world.globaldata['board'];
    //if ((pos.x >= board.hack_area.left) && (pos.y+size.height <= board.hack_area.bottom)) {
    //  if ((x-xoffset <= board.hack_area.left) || (y-yoffset+size.height >= board.hack_area.bottom)) { // new position is outside
    //    return true;
    //  }
    //  else {
    //    return false;
    //  }
    //}

    if ((pos.x >= board.hack_area.left) && (x-xoffset <= board.hack_area.left)) {
      return true;
    }
    else if ((pos.y+size.height <= board.hack_area.bottom) && (y-yoffset+size.height >= board.hack_area.bottom)) {
      return true;
    }
    else {
      return false;
    }
  }
}

num distance(Entity e1, Entity e2) {
  Position p1 = e1.get_component(Position);
  Position p2 = e2.get_component(Position);

  Size s1 = e1.get_component(Size);
  Size s2 = e2.get_component(Size);

  // i don't actually need to do all this computation, esp the sqrt, because i'm just comparing distances and not actually using them
  // oh well

  num p1x = p1.x + s1.width/2;
  num p1y = p1.y + s1.height/2;

  num p2x = p2.x + s2.width/2;
  num p2y = p2.y + s2.height/2;

  num dx = (p1x - p2x);
  num dy = (p1y - p2y);
  return math.sqrt(dx*dx + dy*dy);
}

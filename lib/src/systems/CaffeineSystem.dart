part of hacksim;

class CaffeineSystem extends System {
  int caffeine_max;
  num caffeine_level;

  Timer caff_timer;

  math.Random rng = new math.Random();

  int status = 0;
  static const int CRITICAL = 3;
  static const int BAD = 2;
  static const int OVER = 9;

  CaffeineSystem(World world) : super(world) {
    components_wanted = new Set.from([Draggable,]); // only want things that we can move back

    caffeine_max = amount_caffeine_needed(1);
    caffeine_level = caffeine_max;

    world.globaldata['CaffeinePercentage'] = 1;
    world.globaldata['CaffeineLevel'] = caffeine_level;

    world.subscribe_event("GetCaffeine", handle_more);
    world.subscribe_event("NewHackathonStart", handle_newstart);
  }

  void initialize() {
    caff_timer = new Timer.periodic(const Duration(seconds:1), (t)=>(caffeine_tick())); // there's probably a better way to do this
  }

  void handle_more(Map event) {
    int level = world.globaldata['HackathonsAttended'];
    caffeine_level += (1/level) *amount_caffeine_needed(level); // less each time
    update_caffeine_status();
  }

  void handle_newstart(Map event) {
    caffeine_max = amount_caffeine_needed(world.globaldata['HackathonsAttended']);
    update_caffeine_status();
  }

  int amount_caffeine_needed(int level) {
    return (level*20);
  }

  // I really feel like I should do this in process() with an accumulator but I'm not keeping track of the world's dt.
  void caffeine_tick() {
    caffeine_level -= (2*world.globaldata['HackathonsAttended']/10);
    update_caffeine_status();
    if (caffeine_level <= -(0.1*caffeine_max)) {
      world.send_event("YouLose", {"reason": "Caffeine widthrawal."});
      caff_timer.cancel();
    }
  }

  void update_caffeine_status() {
    world.globaldata['CaffeinePercentage'] = (caffeine_level/caffeine_max);
    world.globaldata['CaffeineLevel'] = caffeine_level;
    if (is_critical(caffeine_level)) {
      status = CRITICAL;
    }
    else if (is_bad(caffeine_level)) {
      status = BAD;
    }
    else if (is_overcharged(caffeine_level)) {
      status = OVER;
    }
    else {
      status = 0;
    }
  }
  bool is_critical(num c) => ( (c<0.1*caffeine_max) ? true : false); 
  bool is_bad(num c) => ( (c<0.4*caffeine_max) ? true : false); 
  bool is_overcharged(num c) => ( (c>caffeine_max) ? true : false); 

  void process_entity(Entity e) {
    Position pos = e.get_component(Position);
    Rectangle board = world.globaldata['board'].board_area;

    if (status != 0) {
      num x = rng.nextInt(status);
      num y = rng.nextInt(status);
      x = (rng.nextBool()) ? x : -x;
      y = (rng.nextBool()) ? y : -y;
      if (board.containsPoint(new Point(pos.x+x, pos.y+y))) {
        pos.x += x;
        pos.y += y;
        
        if (e.get_component(Kind).kind == 'api') {
          world.send_event("APIPickup", {'entity':e});
        }
      }
    }
  }
  void remove_entity(Entity e) {}

}

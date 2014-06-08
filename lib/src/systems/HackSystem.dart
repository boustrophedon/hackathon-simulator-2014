part of hacksim;

class HackSystem extends System {
  math.Random rng;
  HackSystem(World world) : super(world) {
    components_wanted = new Set.from([APISlot,]);

    rng = new math.Random();
  }
  
  void initialize() {
    world.globaldata['HackathonsAttended'] = 1;
    world.globaldata['PercentageCompleted'] = 0;
    world.globaldata['HackerCred'] = 0;
    world.subscribe_event("SubmitHack", handle_submit); 
    world.subscribe_event("APIPickup", handle_reset); 
  }

  void handle_submit(Map event) {
    if (world.globaldata['PercentageCompleted'] == 1) {
      var total_apis = apis_in_area();
      if (total_apis>0) {
        world.globaldata['HackerCred'] += (total_apis*5) + rng.nextInt(world.globaldata['HackathonsAttended'])*4;
        if (world.globaldata['AdsServed'] > 0) { // this is stupid
          world.globaldata['money'] += rng.nextInt(world.globaldata['AdsServed']*50);
        }
        world.globaldata['HackathonsAttended']+=1;
        world.globaldata['PercentageCompleted'] = 0;
        world.send_event("NewHackathonStart", {});
      }
    }
  }

  void handle_reset(Map event) {
    if (world.globaldata['PercentageCompleted'] > 0) {
      world.globaldata['PercentageCompleted'] = 0;
      display_annoying_pivot_animation(); 
    }
  }

  void display_annoying_pivot_animation() {
    // send event here to create an entity that is a label+has animation component
  }

  int apis_in_area() {
    Rectangle hack_area = world.globaldata["board"].hack_area;
    int total = 0;
    for (Entity e in entities) {
      var pos = e.get_component(Position);
      var slot = e.get_component(APISlot);
      if ((hack_area.containsPoint(new Point(pos.x, pos.y))) && (slot.api_inside != null)) {
        total+=1;
      }
    }
    return total;
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

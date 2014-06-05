part of hacksim;

class HackSystem extends System {
  Random rng;
  HackSystem(World world) : super(world) {
    components_wanted = null;

    rng = new math.Random();
  }
  
  void initialize() {
    world.globaldata['HackathonsAttended'] = 1;
    world.globaldata['HackerCred'] = 0;
    world.subscribe_event("SubmitHack", handle_submit); 
  }

  void handle_submit(Map event) {
    if (world.globaldata['PercentageCompleted'] == 1) {
      world.globaldata['HackerCred'] += rng.nextInt(world.globaldata['HackathonsAttended']*10);
      world.globaldata['HackathonsAttended']+=1;
      world.send_event("NewHackathonStart", {});
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

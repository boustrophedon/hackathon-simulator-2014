part of hacksim;

class HackSystem extends System {
  HackSystem(World world) : super(world) {
    components_wanted = null;
  }
  
  void initialize() {
    world.globaldata['HackathonsAttended'] = 1;
    world.globaldata['HackerCred'] = 0;
    world.subscribe_event("SubmitHack", handle_submit); 
  }

  void handle_submit(Map event) {
    if (world.globaldata['PercentageCompleted'] == 1) {
      world.globaldata['HackathonsAttended']+=1;
      world.send_event("NewHackathonStart", {});
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

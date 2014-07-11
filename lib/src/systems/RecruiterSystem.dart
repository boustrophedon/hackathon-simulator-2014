part of hacksim;

class RecruiterSystem extends System {
  math.Random rng;
  RecruiterSystem(World world) : super(world) {
    components_wanted = new Set.from([UIPopup,]);
    rng = new math.Random();
  }

  void initialize() {
    world.subscribe_event("NewHackathonStart", handle_newhackathon);
  }

  void handle_newhackathon(Map event) {
    int level = world.globaldata['HackathonsAttended'];
    if (rng.nextInt(level*level) > level)  {
      world.send_event("SpawnEntity", {'type':'recruiter popup'});
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

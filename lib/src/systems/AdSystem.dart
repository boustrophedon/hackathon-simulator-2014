part of hacksim;

class AdSystem extends System {
  math.Random rng;
  AdSystem(World world) : super(world) {
    components_wanted = null;

    rng = new math.Random();
  }
  
  void initialize() {
    world.globaldata['AdsServed'] = 0;
    world.subscribe_event("ServeNewAds", handle_serve); 
  }

  void handle_serve(Map event) {
    if (world.globaldata['HackerCred'] > 5) {
      new_ads();
    }
  }

  void new_ads() {
    world.globaldata['HackerCred'] -= 5;
    world.globaldata['AdsServed'] += 1;
    if (world.globaldata['HackerCred'] > 5) {
      new_ads();
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

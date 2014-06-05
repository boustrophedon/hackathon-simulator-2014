part of hacksim;

class AdSystem extends System {
  Random rng;
  AdSystem(World world) : super(world) {
    components_wanted = null;

    rng = new math.Random();
  }
  
  void initialize() {
    world.globaldata['AdsServed'] = 0;
    world.subscribe_event("ServeAds", handle_serve); 
  }

  void handle_serve(Map event) {
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

part of hacksim;

class APISlotSystem extends System {
  
  List<List<int>> colorpool;
  math.Random rng;

  APISlotSystem(World world) : super(world) {
    components_wanted = new Set.from([APISlot,]);
  }
  
  void initialize() {
    world.subscribe_event("APISlotPickup", handle_pickup);
  }

  void handle_pickup(Map event) {
  }

  void process_entity(Entity e) {}

  void remove_entity(Entity e) {
    if (e.get_component(Kind).kind == 'api slot') {
      APISlot sl = e.get_component(APISlot);
      if (sl.api_inside != null) {
        sl.api_inside.get_component(API).current_apislot = null;
        sl.api_inside = null;
      }
    }
  }
}

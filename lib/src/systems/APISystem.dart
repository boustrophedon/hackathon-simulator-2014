part of hacksim;

class APISystem extends System {
  Entity current_piece = null;
  int xoffset;
  int yoffset;

  APISystem(World world) : super(world) {
    components_wanted = new Set.from([Position, API]);
  }

  void initialize() {
    world.subscribe_event("APIPickup", handle_pickup);
  }

  void handle_pickup(Map event) {
    var api = event['entity'];

    API api_c = api.get_component(API);
    if (api_c.current_apislot != null) {
      api_c.current_apislot.get_component(APISlot).api_inside = null;
      api_c.current_apislot = null;
    }   
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {
    if (e.get_component(Kind).kind == 'api') {
      API a = e.get_component(API);
      if (a.current_apislot != null) {
        a.current_apislot.get_component(APISlot).api_inside = null;
        a.current_apislot = null;
      }
    }
  }
}

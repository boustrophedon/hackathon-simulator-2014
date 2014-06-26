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
    world.subscribe_event("APIDrop", handle_drop);
  }

  void handle_pickup(Map event) {
    var api = event['entity'];

    API api_c = api.get_component(API);
    if (api_c.current_apislot != null) {
      api_c.current_apislot.get_component(APISlot).api_inside = null;
      api_c.current_apislot = null;
    }   
  }

  void handle_drop(Map event) {
    var api = event['entity'];
    var nearest = event['nearest_slot'];
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

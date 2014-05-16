part of hacksim;

class MoneySystem extends System {

  int api_cost = 50;
  int api_slot_cost = 100;

  MoneySystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    world.globaldata['money'] = 100;

    world.subscribe_event("ButtonPressed", handle_buttonpress);
  }

  void handle_buttonpress(Map event) {
    String action = event['action'];
    if (action == "BUY_API") {
      buy_api();
    }
    else if (action == "BUY_SLOT") {
      buy_slot();
    }
  }

  void buy_api() {
    if (world.globaldata['money'] >= api_cost) {
      world.globaldata['money'] -= api_cost;
      world.send_event("SpawnEntity", {'kind':'api'});
    }
  }
  void buy_slot() {
    if (world.globaldata['money'] >= api_slot_cost) {
      world.globaldata['money'] -= api_slot_cost;
      world.send_event("SpawnEntity", {'kind':'api slot'});
    }
  }

  void process_entity(Entity e) {}
}

part of hacksim;

class MoneySystem extends System {

  int api_cost = 50;
  int api_slot_cost = 100;

  MoneySystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    world.globaldata['money'] = 100;

    world.subscribe_event("BuyAPI", handle_apibuy);
    world.subscribe_event("BuyAPISlot", handle_apislotbuy);
  }

  void handle_apibuy(Map event) {
    if (world.globaldata['money'] >= api_cost) {
      world.globaldata['money'] -= api_cost;
      world.send_event("SpawnEntity", {'kind':'api'});
    }
  }
  void handle_apislotbuy(Map event) {
    if (world.globaldata['money'] >= api_slot_cost) {
      world.globaldata['money'] -= api_slot_cost;
      world.send_event("SpawnEntity", {'kind':'api slot'});
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

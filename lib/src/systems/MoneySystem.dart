part of hacksim;

class MoneySystem extends System {

  int api_cost = 50;
  int api_slot_cost = 100;

  math.Random rng;

  MoneySystem(World world) : super(world) {
    components_wanted = null;

    rng = new math.Random();
  }

  void initialize() {
    world.globaldata['money'] = 100;

    world.subscribe_event("BuyAPI", handle_apibuy);
    world.subscribe_event("BuyAPISlot", handle_apislotbuy);
    world.subscribe_event("GetCaffeine", handle_caffeine);
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

  void handle_caffeine(Map event) {
    num level = world.globaldata['HackathonsAttended'];
    if (rng.nextDouble() > (3/level)) {
      num money = world.globaldata['money'];
      if (money > 0) {
        world.globaldata['money'] -= math.min(money, level*5);
      }
    }
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

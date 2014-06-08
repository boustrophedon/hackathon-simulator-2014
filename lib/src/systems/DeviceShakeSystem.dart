part of hacksim;

class DeviceShakeSystem extends System {

  num shakes = 0;
  int shakes_to_complete;

  DeviceShakeSystem(World world) : super(world) {
    components_wanted = null;
    shakes_to_complete = calculate_new_shakes(1);
  }

  void initialize() {
    world.subscribe_event('DeviceMotion', handle_motion);

    world.subscribe_event('APIPickup', handle_reset);
    world.subscribe_event('NewHackathonStart', handle_newstart);
  }

  void handle_motion(Map event) {
    DeviceMotionEvent e = event['DeviceMotionEvent'];

    if (shakes < shakes_to_complete) {
      shakes += 1;
      update_percentage_done();
    }
    else if (shakes == shakes_to_complete) {
      world.send_event('HackReady', {});
    }
  }

  void handle_newstart(Map event) {
    shakes = 0;
    shakes_to_complete = calculate_new_shakes(world.globaldata['HackathonsAttended']);
  }

  void handle_reset(Map event) {
    shakes = 0;
  }

  void update_percentage_done() {
    world.globaldata['PercentageCompleted'] = (shakes/shakes_to_complete); 
  }

  int calculate_new_shakes(int level) {
    return 30*level + 50;
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}

}

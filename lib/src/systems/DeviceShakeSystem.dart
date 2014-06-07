part of hacksim;

class DeviceShakeSystem extends System {

  DeviceShakeSystem(World world) : super(world) {
    components_wanted = null;
  }

  void initialize() {
    world.subscribe_event('DeviceMotion', handle_motion);
  }

  void handle_motion(Map event) {
    DeviceMotionEvent e = event['DeviceMotionEvent'];
    print('do device motion stuff');
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}

}

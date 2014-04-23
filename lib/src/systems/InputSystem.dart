part of hacksim;

class InputSystem extends System {
  InputSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);
    // KeyboardEventStream.onKeyDown(document.body).listen(register_keydown);
    // KeyboardEventStream.onKeyUp(document.body).listen(register_keyup);
    window.onKeyDown.listen(register_keydown);
    window.onKeyUp.listen(register_keyup);

    world.subscribe_event('KeyDown', handle_keydown);
    world.subscribe_event('KeyUp', handle_keyup);
  }

  void register_keydown(KeyEvent e) {
    //world.send_event('KeyDown', {'KeyEvent':e});
    print("KeyDown ${e.keyCode} ${e.charCode} ${e.which}");
  }
  void register_keyup(KeyEvent e) {
    //world.send_event('KeyUp', {'KeyEvent':e});
    print("KeyUp ${e.keyCode} ${e.charCode} ${e.which}");
  }

  void handle_keydown(KeyEvent e) {
    print("KeyDown ${e.keyCode} ${e.charCode}");
  }
  void handle_keyup(KeyEvent e) {
    print("KeyUp ${e.keyCode} ${e.charCode}");
  }

  void process_entity(Entity entity) {}

}

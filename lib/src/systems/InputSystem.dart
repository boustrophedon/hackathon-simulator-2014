part of hacksim;

class InputSystem extends System {
  InputSystem(World world) : super(world) {
    components_wanted = new Set.from([Position,]);
    window.onKeyDown.listen(register_keydown);
    window.onKeyUp.listen(register_keyup);

    // replace the window mousedown/move and touchstart/move with canvas
    // mouseup and touchend should fire regardless of where they end.
    // mouse/touch are separate so that I can have the MouseEvent and TouchEvent
    // in the parameters. it is not necessary though; I think I can just use Event or UIEvent.
    // also, need to actually add the mousemove/touchmove handlers
    window.onMouseDown.listen(register_mousedown);
    window.onMouseUp.listen(register_mouseup);
    window.onTouchStart.listen(register_touchstart);
    window.onTouchEnd.listen(register_touchend);

    world.subscribe_event('KeyDown', handle_keydown);
    world.subscribe_event('KeyUp', handle_keyup);

    world.subscribe_event('MouseDown', handle_mousedown);
    world.subscribe_event('MouseUp', handle_mouseup);
    world.subscribe_event('TouchStart', handle_touchstart);
    world.subscribe_event('TouchEnd', handle_touchend);
  }

  void register_mousedown(MouseEvent e) {
    world.send_event('MouseDown', {'MouseEvent':e});
  }
  void register_mouseup(MouseEvent e) {
    world.send_event('MouseUp', {'MouseEvent':e});
  }
  void register_touchstart(TouchEvent e) {
    e.preventDefault();
    world.send_event('TouchStart', {'TouchEvent':e});
  }
  void register_touchend(TouchEvent e) {
    e.preventDefault();
    world.send_event('TouchEnd', {'TouchEvent':e});
  }

  void register_keydown(KeyEvent e) {
    world.send_event('KeyDown', {'KeyEvent':e});
  }
  void register_keyup(KeyEvent e) {
    world.send_event('KeyUp', {'KeyEvent':e});
  }

  void handle_keydown(Map event) {
    KeyEvent e = event['KeyEvent'];
    print("KeyDown ${e.keyCode} ${e.charCode}");
  }
  void handle_keyup(Map event) {
    KeyEvent e = event['KeyEvent'];
    print("KeyUp ${e.keyCode} ${e.charCode}");
  }

  void handle_mousedown(Map event) {
    MouseEvent e = event['MouseEvent'];
    print("MouseDown ${e.client.x} ${e.client.y}");
  }
  void handle_mouseup(Map event) {
    MouseEvent e = event['MouseEvent'];
    print("MouseUp ${e.client.x} ${e.client.y}");
  }
  void handle_touchstart(Map event) {
    TouchEvent e = event['TouchEvent'];
    if (e.touches.length > 0) {
      Touch t = event['TouchEvent'].touches.first;
      print("TouchStart ${t.client.x} ${t.client.y}");
    }
  }
  void handle_touchend(Map event) {
    TouchEvent e = event['TouchEvent'];
    print("TouchEnd");
  }

  void process_entity(Entity entity) {}

}

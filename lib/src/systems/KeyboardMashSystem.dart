part of hacksim;

class KeyboardMashSystem extends System {
  int cur_keystrokes = 0;
  int keystrokes_to_complete; 
  List<int> last_5_keys;

  KeyboardMashSystem(World world) : super(world) {
    components_wanted = null;
    keystrokes_to_complete = calculate_new_keystrokes(1);

    last_5_keys = new List<int>(5);

  }
  void initialize() {
    world.subscribe_event('KeyDown', handle_keydown);

    world.subscribe_event('APIPickup', handle_reset);

    // nothing emits this event yet
    // after we submit the hack we need to increase the number of keystrokes to finish a hack
    world.subscribe_event('NewHackathonStart', handle_newstart);

    world.globaldata['PercentageCompleted'] = 0;
  }

  void handle_keydown(Map event) {
    // not used for anything currently, but could be.
    KeyboardEvent kbe = event['KeyboardEvent'];

    if (last_5_keys.contains(kbe.keyCode)) {
      return;
    }

    else if (cur_keystrokes < keystrokes_to_complete) {
      cur_keystrokes+=1;
      last_5_keys[cur_keystrokes%5] = kbe.keyCode;
      update_percentage_done();
    }
    else if (cur_keystrokes == keystrokes_to_complete) { 
      world.send_event('HackReady',{});
    }
  }

  void handle_newstart(Map event) {
    cur_keystrokes = 0;
    world.globaldata['PercentageCompleted'] = 0;
    keystrokes_to_complete = calculate_new_keystrokes(world.globaldata['HackathonsAttended']);
  }

  void handle_reset(Map event) {
    if (cur_keystrokes > 0) {
      cur_keystrokes = 0;
      world.globaldata['PercentageCompleted'] = 0;
      display_annoying_pivot_animation();
    }
  }

  void update_percentage_done() {
    world.globaldata['PercentageCompleted'] = (cur_keystrokes/keystrokes_to_complete);
  }

  int calculate_new_keystrokes(int level) {
    return 10*level + 50; // this is intentionally dumb (as is everything else about this project)
  }

  // doesn't do anything now. probably would need to add an animation system or something
  // which i should probably do so I can learn how to do it.
  void display_annoying_pivot_animation() {
    print("PIVOT!!111one!!lol");
  }

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}

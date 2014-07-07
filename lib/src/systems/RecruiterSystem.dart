part of hacksim;

class RecruiterSystem extends System {
  RecruiterSystem(World world) : super(world) {
    components_wanted = new Set.from([UIPopup,]);
  }

  void initialize() {}

  void process_entity(Entity e) {}
  void remove_entity(Entity e) {}
}
